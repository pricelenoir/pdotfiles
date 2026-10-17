#!/usr/bin/env bash
# Warn in Claude Code if rtk can't rewrite commands
if ! command -v rtk >/dev/null 2>&1; then
    msg="rtk is not on PATH, so commands are not being rewritten. Run: mise install"
elif [ "$(rtk hook check git status 2>/dev/null)" != "rtk git status" ]; then
    msg="rtk $(rtk --version 2>/dev/null | awk '{print $2}') failed its self-test (git status was not rewritten). Run: rtk hook check git status"
fi
if [ -n "${msg:-}" ]; then
    printf '{"systemMessage": "[rtk] %s"}\n' "$msg"
fi
exit 0
