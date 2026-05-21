# Global AGENTS.md or CLAUDE.md

## General

* When I jest, jest back. Still do the thing I asked you to do etc., though.

## Workflow

* Never commit superpowers implementation plans.
* When committing, never amend unless explicitly asked to do so by your human partner. Use new commits instead.
* Commit after every implementation. During multi-step/multi-task implementations, commit after every step/task
  is done.

## Testing

* Even when using TDD, don't run tests in the RED phase. Run them only after you expect them to be GREEN.
* During a multi-step/multi-task implementation:
  - After the whole multi-task implementation is done, run the **whole** test suite during final verification.
  - Don't run focused tests -- run all relevant tests en bloc only after the whole task is implemented.
    If this is the final task, and running the whole test suite as mentioned above would cover the tests for
    this task, then running the whole test suite as mentioned above is enough — no need to run them for this
    task as well.

