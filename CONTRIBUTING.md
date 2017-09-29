## Contributing to GitHawk

This project is continuing to develop rapidly and new features are constantly being added. Pull Requests **are** accepted but please note that `master` is constantly changing and your submissions may go stale quick. Be warned!

### Setup

In order to compile and run GitHawk locally, you will need to provide your own client ID and secret keys from GitHub. You can get these by [registering](https://github.com/settings/applications/new) a new OAuth application. The "Authorization callback URL" must be set to `freetime://`, otherwise you're free to fill it in yourself!

Once you have your client ID and secret you can populate these values into the [Secrets.swift](https://github.com/rnystrom/GitHawk/blob/master/Classes/Other/Secrets.swift) file. You should **never** commit these changes!

Finally, you will also need to install `apollo-codegen`, this is a command line tool which is required to create the GraphQL models! This can be done easily by running `npm install`.

### Pull Requests

All changes should be made off of the latest version of `master`. If a Pull Request is still being worked on then please make this obvious by including "WIP" in the title!

Pull Requests should have a suitable amount of testing done to ensure it doesn't break the app, and we do appreciate new unit tests being created although this isn't currently enforced in the aim of releasing faster!

### Issues

We use [GitHub issues](https://github.com/rnystrom/GitHawk/issues) in order to track feature requests and bugs! You can raise bugs through the app itself from the Settings page and then tap "Report a Bug" - this will also include some device specific information to make fixing those bugs a little bit easier!

### Beta Testing

We use [TestFlight](https://itunes.apple.com/gb/app/testflight/id899247664?mt=8) in order to distribute beta versions of this application. If you're interested in helping then DM [@GitHawk](https://twitter.com/GitHawk) on Twitter with your email address and you'll be added to the list!

### License

By contributing to `GitHawk`, you agree that your contributions will be licensed under the terms found in our [LICENSE](https://github.com/rnystrom/GitHawk/blob/master/LICENSE) file. You understand that this project is released, for free, on the iOS App Store.
