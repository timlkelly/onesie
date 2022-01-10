---
title: task
description:
type: explanation
created_at: 2022-01-05
---

# Task
The Task class represents an individual Onesie Task to be executed. It must
include the `#run` method, although additional methods can be added if needed.

## Example Task Template
```ruby
# onesie/tasks/20220105140152_my_task.rb

module Onesie
  module Tasks
    class MyTask < Onesie::Task
      allowed_environments :all
      manual_task enabled: false

      def run
        # Write your Onesie Task here
      end
    end
  end
end
```

## Task Macros
There are a few class Macros defined in the base class to assist with writing
tasks.

### `allowed_environments`
Adds a guard clause to check against the current `Rails.env`. Available options
are
  - :production
  - :staging
  - :integration
  - :development
  - :all (default)

This method can accept multiple environments.

#### Examples
```ruby
allowed_environments :production            # Only runs in production
allowed_environments :integration, :staging # Only runs in integration and staging
allowed_environments :development           # Only runs in development
```


### `manual_task`
Adds a guard to exlcude this task from the `onesie:run_tasks` and
`onesie:run_all` rake commands.
This is useful when you have a onesie that will take a long time to run and you
don't want it to hold up other onesies.
To run a manual task use the following rake task

```bash
rake onesie:run[filename]              # Manually run a specific Onesie Tasks
```

#### Examples

```ruby
manual_task enabled: true
manual_task enabled: false
```
