# Setup

To be able to log in during development, you'll need a Client ID and Client Secret.
To get these, [register](https://github.com/settings/applications/new) a new OAuth application on GitHub.

## Registering

Here, you will need to fill in an Application name, Homepage URL and Authorization callback URL.
Make sure the Authorization callback URL is set to `freetime://`. The others can be filled in as you wish.

You'll be redirected to the application page where you can access your Client ID and Client Secret.

To add the Client ID and Client Secret to the App, follow these steps:

1. In Xcode, go to `Product` (in the Menu bar) > `Scheme` > `Manage Schemes...`
2. Select `Freetime` and click `Edit...`
3. Go to `Run` > `Arguments`
4. Add your Client ID (`GITHUB_CLIENT_ID` as key) and Client Secret (`GITHUB_CLIENT_SECRET`) to the Environment Variables.
