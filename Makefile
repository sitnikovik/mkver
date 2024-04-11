# Release patch version
patch:
	bash ./bin/semver-builder patch -d

# Release minor version
minor:
	bash ./bin/semver-builder minor -d

# Release major version
major:
	bash ./bin/semver-builder major -d