# nixpkg-git-fetch-head
Do `git-fetch` a `HEAD` of a `nix` package.

e.g. `. nixpkg-git-fetch-head pkgs/applications/science/logic/coq/HEAD.nix`

The script takes care of 1. getting the latest commit hash, human-readable version, and the sha256 hash of the repo, 2. updating the values into the HEAD.nix file.
