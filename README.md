# semver-builder

Tool to build semantic versions for your project stored in Git.

## How to build

```shell
# make patch
bash semver-builder.sh patch
```

```shell
# make minor
bash semver-builder.sh minor
```

```shell
# make major
bash semver-builder.sh major
```

If you to comment version with tag message
```shell
# make major
bash semver-builder.sh patch "Yet another version"
```