# Helvellyn

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/thombruce/helvellyn/CI)](https://github.com/thombruce/helvellyn/actions)

[![GitHub](https://img.shields.io/github/license/thombruce/helvellyn)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Contributing](https://img.shields.io/badge/contributions-welcome-blue.svg)](CONTRIBUTING.md)

A Ruby on Rails based content management system that exposes a customisable API for publishing content.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development](#development)

## Getting Started

```shell
git clone https://github.com/thombruce/helvellyn.git
cd helvellyn
rake db:setup
rails s
```

## Development

Helvellyn devlopment uses [GitHub Flow](https://guides.github.com/introduction/flow/), which is a very minimalist approach to Git flow. The master branch is always production-code, ready to deploy. Code that is in development is reviewed in isolation on its own feature branch and its related pull request before being merged to master.

### TODO

- [x] GitHub Actions
- [x] Heroku Review Apps
- [ ] Coverage Reporting
