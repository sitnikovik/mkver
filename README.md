# semver-builder

Tool to build semantic versions for your project stored in Git.

## How to build

### Arguments and options

There are 
- Arguments
  - version type (one of `patch`, `minor`, `major`)
- Options
  - `-pa` to make *pre-alpha* version
  - `-a` to make *alpha* version
  - `-b` to make *beta* version
  - `-rc` to make *release-candidate* version
  - `-m` to specify version with some description
  - `-mt` to specify version prefix with custom meta information

### Examples

```shell
# Makes patch as `0.0.1`
bash semver-builder.sh patch
```

```shell
# Makes minor as `0.1.0-beta`
bash semver-builder.sh minor -b
```

```shell
# Makes minor as `0.1.0-beta+1691045114`
bash semver-builder.sh minor -b -mt "$(date +%s)"
```

```shell
# Makes minor as `0.1.0-beta+some_meta_info`
bash semver-builder.sh minor -b -mt "some_meta_info"
```

```shell
# Makes minor as `0.1.0-beta` with tag message "Yet another version"
bash semver-builder.sh minor -b -m "Yet another version"
```

```shell
# Makes version with wget
bash <(wget -qO- https://raw.githubusercontent.com/sitnikovik/semver-builder/master/semver-builder.sh) 
```

## Telegram notifying
Use `notify-tg.sh` to send message with current version and commit description to some chat 
to get you team notified about some updates deployed.

### Arguments and options

There are
- Required arguments
  - Telegram chat id
  - Telegram Bot token
- Options
  - `-app` to specify app instance name in message

```shell
bash notify-tg.sh "your_chat_id" "your_tg_bot_token" -app "stg.my_project"
```
**Sends message like**:
```text
#deploy
app: `stg.my_project`
version: `v0.0.1`

Some commit message...
```
