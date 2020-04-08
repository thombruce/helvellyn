# System Specs

*You may need to install [Chromedriver](https://chromedriver.chromium.org/) to run system specs.*

In support of system specs, Capybara and Selenium Webdriver were added to the Gemfile:

```ruby
group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
```

Capybara is loaded and configured in `spec/rails_helper.rb`:

```ruby
require 'capybara/rails'
Capybara.server = :puma, { Silent: true }
```

To run these specs on GitHub Actions, the following shell command was added to `.github/workflows/main.yml`:

```yml
- name: Precompile Assets
  run: |
    bundle exec rails assets:precompile
```

*Without this, no manifest file is created and Rspec cannot load the JavaScript packs.*

**NOTE: JavaScript code coverage cannot be determined by any Ruby code coverage tool that I know of (Helvellyn uses SimpleCov). Recommend moving JS pack to independent package distributed by NPM, so that JavaScript can be tested in isolation.**
