# GitHawk Security FAQ

## How does GitHawk authenticate access to repositories?

GitHawk requests a GitHub OAuth token with the `repo`, `user`, and
`notifications` scopes. According to the GitHub
[documentation](https://developer.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/),
these scopes allow read/write access to profile information, read access to
the authenticated user's notifications, and read/write access to code and
commit messages for all public and private repositories to which the
authenticating user has access.

## How does GitHawk store passwords?

By using OAuth, GitHawk avoids needing to store any passwords on the device or
in the cloud.

## How does GitHawk store authentication tokens?

GitHawk stores an OAuth session token on the device in order to maintain the user's
OAuth session across multiple runs of the app. This token has an expiry and is
never uploaded to any servers.

## Does GitHawk store source code?

GitHawk stores some repository information on the device, including source
code, pull request contents, and issue contents. This information is stored
for the purpose of speeding up the app's user experience and reducing the
nuber of redundant calls it needs to make to the GitHub API. Source code and
other information downloaded using the `repo` OAuth scope is never uploaded to
any servers.

## When does GitHawk read source code from my repository?

GitHawk reads source code from repositories only in the form of pull request
diffs. Git patches, which contain multiple versions of relevant source code
snippets, are read via GitHub API requests when the user asks to read the code
corresponding to a given pull request. GitHawk does not read repo source code
at any other time.

## Does GitHawk ever clone my repositories?

GitHawk does not clone Git repositories for any reason. All repo-specific
information is acquired via OAuth-authenticated requests to the GitHub API.

## When does GitHawk write to repositories?

GitHawk writes to repositories only at the user's request. This includes
actions like commenting on an issue or merging a pull request. GitHawk never
writes to repositories without some explicit form of user confirmation
immediately preceding the action.

## What data does GitHawk upload to non-GitHub servers?

GitHawk does not upload any information gathered via the GitHub API to
third-party servers.

## Are logs kept on who accesses what data via GitHawk?

Logs are kept locally on the device for the purpose of debugging.
