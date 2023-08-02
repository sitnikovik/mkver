#!/usr/bin/bash

###> Colors ###
RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
YELLOW_COLOR='\033[0;33m'
CYAN_COLOR='\033[0;36m'
COLOR_OFF='\033[0m'
###< Colors ###

###> Making version ###
WORKDIR="."
VERSION_FILE=$WORKDIR/VERSION
if [ ! -f "$VERSION_FILE" ]; then
  touch $VERSION_FILE
  echo -e "${YELLOW_COLOR}WARNING${COLOR_OFF}: Created ${CYAN_COLOR}$VERSION_FILE${COLOR_OFF} cause of not found";
fi
VERSION="$(cat $VERSION_FILE)"
VERSION=${VERSION:1}
VERSION_MAJOR=0
VERSION_MINOR=0
VERSION_PATCH=0
VERSION_TYPES_TAGS="major, minor, patch"

IFS='.'  # space is set as delimiter
read -ra VERSION_PARTS <<< "$VERSION"   # str is read into an array as tokens separated by IFS

INDEX=0
for i in "${VERSION_PARTS[@]}"; do   # access each element of array
  if [ $INDEX == 0 ]; then
    VERSION_MAJOR=$i
  fi
  if [ $INDEX == 1 ]; then
    VERSION_MINOR=$i
  fi
  if [ $INDEX == 2 ]; then
    VERSION_PATCH=$i
  fi

  (( INDEX++ ))
done

if [ -n "$1" ]; then
  case "$1" in
  patch)
    echo "Making patch..."
    (( VERSION_PATCH++ ))
    ;;
  minor)
    echo "Making minor..."
    VERSION_PATCH=0
    (( VERSION_MINOR++ ))
    ;;
  major)
    echo -e "${RED_COLOR}WARNING${COLOR_OFF}: ${YELLOW_COLOR}Going to build major! Please ensure your doing...${COLOR_OFF}";
    echo "Making major..."
    VERSION_PATCH=0
    VERSION_MINOR=0
    (( VERSION_MAJOR++ ))
    ;;
  *)
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: \"$1\" is unknown version type. Available: ${VERSION_TYPES_TAGS}"
    exit 128
    ;;
  esac
else
  echo -e "${RED_COLOR}ERROR${COLOR_OFF}: provider version type of [${VERSION_TYPES_TAGS}]"
  exit 128
fi

VERSION="v$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"

echo -e "Going to release ${YELLOW_COLOR}$VERSION${COLOR_OFF}"
# shellcheck disable=SC2162
read -p "Do you wish to make release? [y/N]: " yn
    case $yn in
        [Yy]* );;
        * )
          echo -e "${RED_COLOR}Aborted${COLOR_OFF}";
          exit 0
          ;;
    esac
###< Making version ###

###> Deploying ###
# Version description
MESSAGE=$2

# Git branch for version
BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ ! "$BRANCH" ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: local git branch not specified!"
    exit 1
fi
if [ "$BRANCH" != "master" ] && [ "$BRANCH" != "main" ]; then
  echo -e "${YELLOW_COLOR}WARNING${COLOR_OFF}: you checked out ${CYAN_COLOR}$BRANCH${COLOR_OFF} git branch!"
  # shellcheck disable=SC2162
  read -p "Continue? [y/N]: " yn
      case $yn in
          [Yy]* );;
          * )
            echo -e "${RED_COLOR}Aborted${COLOR_OFF}";
            exit 0
            ;;
      esac
  exit 1;
fi

if [ ! -d ./.git ]; then
    echo -e "${RED_COLOR}ERROR${COLOR_OFF}: .git folder not found!"
    exit 1
fi

git fetch --tags
if [ "$MESSAGE" ]; then
  git tag -a "$VERSION" -m "$MESSAGE" && \
  git push && \
  git push origin --tags && \
  echo "$VERSION" > "$VERSION_FILE" && \
  echo -e "${GREEN_COLOR}SUCCESS${COLOR_OFF}: $VERSION released!${COLOR_OFF}"
else
  git tag -a "$VERSION" -m "$MESSAGE" && \
  git push && \
  git push --tags && \
  echo "$VERSION" > "$VERSION_FILE" && \
  echo -e "${GREEN_COLOR}SUCCESS${COLOR_OFF}: $VERSION released!${COLOR_OFF}"
fi
###< Deploying ###