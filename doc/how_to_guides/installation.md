---
title: installation
description:
type: how_to_guide
created_at: 2021-12-21
---

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'onesie', git: 'git@github.com:watermelonexpress/onesie.git', tag: 'v0.1.0'
```

And then execute `bundle install`

Next, generate the required migration file and migrate:

```bash
bundle exec rails generate onesie:install
bundle exec rake db:migrate
````
