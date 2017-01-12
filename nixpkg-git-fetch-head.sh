NIXFILE=$1
URL=$(cat $NIXFILE | grep 'url =' | cut -c11-)
URL=${URL:0:-1}  # remove trailing semicolon

HEAD=$(git ls-remote $URL HEAD | cut -f1)
METADATA=$(./pkgs/build-support/fetchgit/nix-prefetch-git --deepClone --url $URL --rev $HEAD 2>&1)
VERSION=$(echo "$METADATA" | grep 'git human-readable' | cut -d' ' -f5)
SHA256=$(echo "$METADATA" | grep sha256 | cut -d':' -f2 | cut -d'"' -f2)

# edit file in-place
sed -i "s/ rev = \".*\";/ rev = \"$HEAD\";/" $NIXFILE
sed -i "s/ version = \".*\";/ version = \"$VERSION\";/" $NIXFILE
sed -i "s/ sha256 = \".*\"/ sha256 = \"$SHA256\"/" $NIXFILE

