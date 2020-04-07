# Helvellyn

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

[![CI](https://github.com/thombruce/helvellyn/workflows/CI/badge.svg)](https://github.com/thombruce/helvellyn/actions)
[![codecov](https://codecov.io/gh/thombruce/helvellyn/branch/master/graph/badge.svg)](https://codecov.io/gh/thombruce/helvellyn)
[![GitHub issues](https://img.shields.io/github/issues-raw/thombruce/helvellyn?logo=github)](https://github.com/thombruce/helvellyn/issues)

[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](CODE_OF_CONDUCT.md)
[![Contributing](https://img.shields.io/badge/contributions-welcome-blue.svg)](CONTRIBUTING.md)
[![Discord](https://img.shields.io/discord/697123984231366716?color=7289da&label=chat&logo=discord)](https://discord.gg/JDSh5dQ)

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

![GitHub Flow](https://i.imgur.com/zE06Jon.png)

Helvellyn devlopment uses [GitHub Flow](https://guides.github.com/introduction/flow/), which is a very minimalist approach to Git flow. The master branch is always production-code, ready to deploy. Code that is in development is reviewed in isolation on its own feature branch and its related pull request before being merged to master.

### TODO

- [x] GitHub Actions
- [x] Heroku Review Apps
- [x] Coverage Reporting
- [ ] Achieve min. coverage of 80%
- [ ] Consider use of GitHub projects for multi-part tasks
