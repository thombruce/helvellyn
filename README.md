# Helvellyn ![GitHub package.json version](https://img.shields.io/github/package-json/v/thombruce/helvellyn)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thombruce/helvellyn/CI?logo=github)](https://github.com/thombruce/helvellyn/actions)
[![Codecov](https://img.shields.io/codecov/c/github/thombruce/helvellyn?logo=codecov)](https://codecov.io/gh/thombruce/helvellyn)
[![GitHub issues](https://img.shields.io/github/issues-raw/thombruce/helvellyn?logo=github)](https://github.com/thombruce/helvellyn/issues)

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Contributing](https://img.shields.io/badge/contributions-welcome-blue.svg)](CONTRIBUTING.md)
[![Discord](https://img.shields.io/discord/697123984231366716?color=7289da&label=chat&logo=discord)](https://discord.gg/JDSh5dQ)

A Ruby on Rails based content management system that exposes a customisable API for publishing content.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development](#development)
3. [Testing](#testing)
4. [Sponsors](#sponsors)
5. [Maintainers](#maintainers)
6. [Contributors](#contributors)
7. [Todo](#todo)

## Getting Started

```shell
git clone https://github.com/thombruce/helvellyn.git
cd helvellyn
rake db:setup
rails s
```

## Development

![GitHub Flow](https://i.imgur.com/zE06Jon.png)

Helvellyn devlopment uses [GitHub Flow](https://guides.github.com/introduction/flow/), which is a very minimalist approach to Git flow. The master branch is always production-code, ready to deploy. Code that is in development is reviewed in isolation on its own feature branch and its related pull request before being merged to master.

## Testing

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thombruce/helvellyn/CI?logo=github)](https://github.com/thombruce/helvellyn/actions)
[![Codecov](https://img.shields.io/codecov/c/github/thombruce/helvellyn?logo=codecov)](https://codecov.io/gh/thombruce/helvellyn)

```shell
bundle exec rspec
```

*You may need to install [Chromedriver](https://chromedriver.chromium.org/) to run system specs.*

To exclude system specs from the test run:

```shell
bundle exec rspec --exclude-pattern "spec/system/**/*.rb"
```

## Sponsors

Details about how you can sponsor the project to follow.

_Sponsors will be listed here._

## Maintainers

[![thombruce](https://avatars1.githubusercontent.com/u/3887509?s=60&v=4)](https://github.com/thombruce)

## Contributors

_Significant contributors will be listed here._

## Todo

[![GitHub issues](https://img.shields.io/github/issues-raw/thombruce/helvellyn?logo=github)](https://github.com/thombruce/helvellyn/issues)

- [x] GitHub Actions
- [x] Heroku Review Apps
- [x] Coverage Reporting
- [ ] Achieve min. coverage of 80%
- [ ] Consider use of GitHub projects for multi-part tasks
- [ ] Separation into engines/packages:
    - Helvellyn::Admin - Admin API for Helvellyn CMS
    - Helvellyn::Api - Public API for Helvellyn CMS
    - Helvellyn::Auth - Authentication API for Helvellyn CMS (I may have different plans for this)
    - HelvellynJS - Frontend JavaScript
