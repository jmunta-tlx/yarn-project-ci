#!/bin/bash -x
pwd
echo "new_release_version=$1" > new_release_version.txt
NEW_VERSION=`echo $1 | cut -d'v' -f2`
echo "new = $NEW_VERSION"
sed -i 's/"version": .*/"version": "'"$NEW_VERSION"'",/g' package.json
