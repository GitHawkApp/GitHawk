# Getting Started

You can contribute to this project by forking the repo and submitting a pull request via GitHub.
In order to compile the project there's a few requirements you must first satisfy.

## Running on a Device (optional)

Select your Team from the project settings to ensure signing will work when running on a device.

## Creating a GitHub App

Visit https://github.com/settings/applications/new to setup a new application with the following settings.

Name: `Freetime`
Callback URL: `freetime://`

In the following step you'll require the Client ID and Secret from this application.

## Client ID and Secret

When first cloning the repo, you will notice the following files are missing: 
- FREETIME-DEBUG.xcconfig
- FREETIME-RELEASE.xcconfig

Simply compile the project to have these files generated for you. Then select the appropriate configuration and paste your Client ID and Secret into the required fields.

> These files are never committed to the repo so you don't need to worry about unstaging your commits. These are your local copies only!
