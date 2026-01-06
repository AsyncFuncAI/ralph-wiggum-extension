# Ralph Wiggum Extension for Gemini CLI

This document outlines the behavior of the Ralph Wiggum extension for iterative development loops in Gemini CLI.

## Command: /ralph-loop

### Purpose
Start a self-referential development loop where Gemini iteratively works on a task until completion.

### Activation
When a user runs `/ralph-loop <prompt>`, you MUST:

1. **Run the setup script** to create the state file:
   ```bash
   bash "${extensionPath}/scripts/setup-ralph-loop.sh" <prompt> [options]
   ```

2. **Read the state file** at `.gemini/ralph-loop.local.md`

3. **Begin working** on the task described in the prompt

4. **Iterate** until completion or max iterations reached

### Options
- `--max-iterations <n>` - Stop after N iterations (default: unlimited)
- `--completion-promise '<text>'` - Phrase that signals task completion

### Completion
To signal completion when a promise is set, output:
```
<promise>YOUR_COMPLETION_PHRASE</promise>
```

**CRITICAL:** Only output the promise when the statement is genuinely TRUE. Do NOT lie to exit the loop.

## Command: /cancel-ralph

### Purpose
Cancel an active Ralph loop.

### Behavior
Run the cancellation script:
```bash
bash "${extensionPath}/scripts/cancel-ralph-loop.sh"
```

Then report final status to the user.

## State File Format

The state file `.gemini/ralph-loop.local.md` uses YAML frontmatter:

```yaml
---
active: true
iteration: 1
max_iterations: 0
completion_promise: "DONE"
started_at: "2025-01-06T12:00:00Z"
---

The task prompt goes here...
```

## Philosophy

Ralph embodies iterative improvement:
- **Iteration > Perfection**: Refine through multiple passes
- **Failures Are Data**: Learn from each iteration
- **Persistence Wins**: Keep trying until success
- **Trust the Process**: Don't circumvent the loop with false completion

