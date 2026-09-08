#!/usr/bin/env python3
import sys, json
from datetime import datetime

# Claude Code omits a rate-limit window from the statusline payload once that
# window's reset time has passed and no API response has reported the new window
# yet. Nothing is used in a lapsed window, so report it as zero, not as unknown.
LAPSED_WINDOW_PCT = 0

# Plan rate limits do not apply to API key, Bedrock and Vertex sessions, nor to a
# profile lacking the usage scope. Claude Code then reports no windows at all, and
# there is no percentage to state -- as opposed to a window that merely lapsed.
LIMITS_UNAVAILABLE_PCT = "--"

def main():
    try:
        ctx = json.loads(sys.stdin.read())
    except Exception:
        print("Ctx --% | 5h --% | 7d --%")
        return

    def fmt(v):
        return f"{round(v)}%" if isinstance(v, (int, float)) else f"{v}%"

    ctx_data = ctx.get("context_window") or {}
    ctx_pct = ctx_data.get("used_percentage") or 0

    # Sum current usage tokens
    current = ctx_data.get("current_usage") or {}
    total_tokens = (
        current.get("input_tokens", 0)
        + current.get("output_tokens", 0)
        + current.get("cache_creation_input_tokens", 0)
        + current.get("cache_read_input_tokens", 0)
    )

    def fmt_tokens(n):
        if n >= 1_000_000:
            return f"{round(n / 1_000_000)}M"
        elif n >= 1_000:
            return f"{round(n / 1_000)}k"
        return str(n)

    limits = ctx.get("rate_limits") or {}
    missing_pct = (
        LAPSED_WINDOW_PCT
        if ctx.get("rate_limits_available", True)
        else LIMITS_UNAVAILABLE_PCT
    )

    five_h_data = limits.get("five_hour") or {}
    five_h = five_h_data.get("used_percentage", missing_pct)
    seven_d = (limits.get("seven_day") or {}).get("used_percentage", missing_pct)

    resets_at = five_h_data.get("resets_at")
    if resets_at:
        reset_str = datetime.fromtimestamp(resets_at).strftime("%-H:%M")
        five_h_label = f"5h {fmt(five_h)} ↻{reset_str}"
    else:
        five_h_label = f"5h {fmt(five_h)}"

    seven_d_data = limits.get("seven_day") or {}
    seven_d_reset_at = seven_d_data.get("resets_at")
    if seven_d_reset_at:
        seven_d_reset_str = datetime.fromtimestamp(seven_d_reset_at).strftime("%a %-H:%M")
        seven_d_label = f"7d {fmt(seven_d)} ↻{seven_d_reset_str}"
    else:
        seven_d_label = f"7d {fmt(seven_d)}"

    import re
    model_obj = ctx.get("model") or {}
    model = model_obj.get("display_name", "")
    model_label = re.sub(r"\((\S+)\s+context\)", r"[\1]", model)

    effort = (ctx.get("effort") or {}).get("level")
    if effort:
        model_label = f"{model_label} {effort}".strip()

    ctx_label = f"Ctx {fmt(ctx_pct)} {fmt_tokens(total_tokens)}"
    parts = [p for p in [model_label, ctx_label, five_h_label, seven_d_label] if p]
    print(" | ".join(parts))

if __name__ == "__main__":
    main()
