# semver-builder

Tool to build semantic versions for your project stored in Git.

## Install

Makes binary `mkver` for your local user

```shell
bash <(wget -qO- https://raw.githubusercontent.com/sitnikovik/semver-builder/master/bin/installer)
```

There are
- Options
  - `-n` to make binary with your custom name ever you prefer. For example `-n command_name`
  - `-f` to make binary without any confirms with default settings

## How to build

### Arguments and options

There are 
- Arguments
  - version type (one of `patch`, `minor`, `major`)
  - `local` to make version with local tag without push to origin
- Options
  - `-pa` to make *pre-alpha* version
  - `-a` to make *alpha* version
  - `-b` to make *beta* version
  - `-rc` to make *release-candidate* version
  - `-m` to specify version with some description
  - `-mt` to specify version prefix with custom meta information
  - `-f` to make version without any confirms

### Examples

```shell
# Makes patch as `0.0.1`
bash mkver patch
```

```shell
# Makes minor as `0.1.0-beta`
bash mkver minor -b
```

```shell
# Makes minor as `0.1.0-beta+1691045114`
bash mkver minor -b -mt "$(date +%s)"
```

```shell
# Makes minor as `0.1.0-beta+some_meta_info`
bash mkver minor -b -mt "some_meta_info"
```

```shell
# Makes minor as `0.1.0-beta` with tag message "Yet another version"
bash mkver minor -b -m "Yet another version"
```

```shell
# Makes patch as `0.0.1` with local tag
bash mkver patch local
```

```shell
# Makes version with wget
bash <(wget -qO- https://raw.githubusercontent.com/sitnikovik/semver-builder/master/bin/semver-builder) 
```
