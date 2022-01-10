---
title: overview
description:
type: explanation
created_at: 2021-12-21
---

# Overview

## What is a Onesie?
A onesie is a task or script that needs to be executed only once per
environment, hence the name. A record of each Onesie will be stored in the
database to ensure that it will only be ran once.

## Best Practices
- Include the Jira ticket code in your onesie to provide context
- Use `bundle exec` to avoid gem version issues, e.g.
  `bundle exec rake onesie:new[...]`
- Use the Rake Task or Rails Generator to create a onesies; **Do not** manually
  create or copy onesies files
- Onesies **should** be idempotent
  - This means the onesie can be run multiple times without raising an error or
    causing unintended side-effects
- Avoid long-running tasks
  - If this is unavoidable, add logging or use the `ScriptProgress` helper to
    provide insight
  - Consider whether the task should be a manual task so it doesn't hold up
    other tasks
