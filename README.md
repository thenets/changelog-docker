# Changelog Docker

Docker version for changelog.com open source CMS

## What Is Included?
- Elixir 1.6 
- [Changelog.com project (master branch)](https://github.com/thechangelog/changelog.com)

## 1. Requirements
Your server / virtual machine must meet the following requirements:

- Linux x64 kernel version 3.10 or higher
- 100 MB of RAM
- Docker (curl -sSL https://get.docker.io | sudo sh)

## 2. How To Use

You can build and test the project using the following commands:

```
# Build
make

# Start and test
make test

# Go to shell inside the container
make shell

# You can also build and start test or shell with one command
make build-test
make build-shell
```

## TODO

- Create Docker Compose
- Add volume
- Add to Docker Hub