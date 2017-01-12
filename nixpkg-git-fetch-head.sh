NIXFILE=$1
URL=$(cat $NIXFILE | grep 'url =' | cut -c11-)
URL=${URL:0:-1}  # remove trailing semicolon

HEAD=$(git ls-remote $URL HEAD | cut -f1)  # HEAD hash
METADATA=$(./pkgs/build-support/fetchgit/nix-prefetch-git --deepClone --url $URL --rev $HEAD 2>&1)  # get the repo metadata
VERSION=$(echo "$METADATA" | grep 'git human-readable' | cut -d' ' -f5 | sed 's/-[0-9]*-/-/')  # in the last step, the total number of tags of the repo is clipped away
SHA256=$(echo "$METADATA" | grep sha256 | cut -d':' -f2 | cut -d'"' -f2)

# edit file in-place
# TODO: this doesn't work with multiple fetchgit in one file
sed -i "s/ rev = \".*\";/ rev = \"$HEAD\";/" $NIXFILE
sed -i "s/ version = \".*\";/ version = \"$VERSION\";/" $NIXFILE
sed -i "s/ sha256 = \".*\"/ sha256 = \"$SHA256\"/" $NIXFILE

