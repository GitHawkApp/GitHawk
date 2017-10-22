#!/bin/bash

git=$(sh /etc/profile; which git)

# Use commit count for CFBundleVersion (must always increment)
number_of_commits=$("$git" rev-list HEAD --count)

# Get the full commit hash for GitHawkHeadCommitHash
git_release_version=$("$git" describe --always --abbrev=0)

target_plist="$TARGET_BUILD_DIR/$INFOPLIST_PATH"
dsym_plist="$DWARF_DSYM_FOLDER_PATH/$DWARF_DSYM_FILE_NAME/Contents/Info.plist"

for plist in "$target_plist" "$dsym_plist"; do
  if [ -f "$plist" ]; then
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $number_of_commits" "$plist"
    # /usr/libexec/PlistBuddy -c "Set :GitHawkHeadCommitHash ${git_release_version#*v}" "$plist"
  fi
done
