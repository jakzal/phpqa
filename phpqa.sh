#!/usr/bin/env sh
#
# Place this script in /usr/local/bin/:
# sudo cp phpqa.sh /usr/local/bin/phpqa
# Now you can run phpqa from everywhere

IMAGE_VERSION="latest" # [latest|alpine]

docker run -it --rm -v $(pwd):/project -w /project jakzal/phpqa:$IMAGE_VERSION "$@"
