#!/usr/bin/env python3
import sys, json
from datetime import datetime

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
    five_h_data = limits.get("five_hour") or {}
    five_h = five_h_data.get("used_percentage", "--")
    seven_d = (limits.get("seven_day") or {}).get("used_percentage", "--")

    resets_at = five_h_data.get("resets_at")
    if resets_at:
        reset_str = datetime.fromtimestamp(resets_at).strftime("%-H:%M")
        five_h_label = f"5h {fmt(five_h)} ↻{reset_str}"
    else:
        five_h_label = f"5h {fmt(five_h)}"

    import re
    model = (ctx.get("model") or {}).get("display_name", "")
    model_label = re.sub(r"\((\S+)\s+context\)", r"[\1]", model)

    ctx_label = f"Ctx {fmt(ctx_pct)} {fmt_tokens(total_tokens)}"
    parts = [p for p in [model_label, ctx_label, five_h_label, f"7d {fmt(seven_d)}"] if p]
    print(" | ".join(parts))

if __name__ == "__main__":
    main()
