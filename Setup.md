# Setup

To be able to log in during development, you'll need a Client ID and Client Secret.
To get these, [register](https://github.com/settings/applications/new) a new OAuth application on GitHub.

## Registering

Here, you will need to fill in an Application name, Homepage URL and Authorization callback URL.
Make sure the Authorization callback URL is set to `freetime://`. The others can be filled in as you wish.

You'll be redirected to the application page where you can access your Client ID and Client Secret.
Simply change the standard values in [Secrets.swift](Classes/Other/Secrets.swift) with your values and you're good to go.
