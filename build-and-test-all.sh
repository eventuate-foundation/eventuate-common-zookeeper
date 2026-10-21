#! /bin/bash -e

# Builds the eventuate-zookeeper image with the tag that EventuateZookeeperContainer uses, the project version,
# and then runs the tests, including LeadershipTest and EventuateZookeeperContainerTest, against it.
# In CircleCI, set-multi-arch-image-env-vars.sh sets ZOOKEEPER_MULTI_ARCH_IMAGE to the image that the
# build-multi-arch-image-zookeeper job pushed, and that image is tested instead of a local build.

VERSION=$(sed -n 's/^version=//p' gradle.properties)
IMAGE=eventuateio/eventuate-zookeeper:$VERSION

if [ -n "$ZOOKEEPER_MULTI_ARCH_IMAGE" ] ; then
  docker pull $ZOOKEEPER_MULTI_ARCH_IMAGE
  docker tag $ZOOKEEPER_MULTI_ARCH_IMAGE $IMAGE
else
  docker build -t $IMAGE zookeeper
fi

./gradlew build
