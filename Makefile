# Build binary file from source code for installer
build:
	cp semver-builder.sh ./bin/semver-builder && chmod +x ./bin/semver-builder

# Release patch version
patch:
	bash semver-builder.sh patch -d

# Release minor version
minor:
	bash semver-builder.sh minor -d

# Release major version
major:
	bash semver-builder.sh major -d