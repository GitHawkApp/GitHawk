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

You will need to compile the project to have these files generated for you. In some cases the file will be created but a compile error will occur. Simply clean the project (CMD+SHIFT+K) and compile again (CMD+B) and everything should work fine. 

> Although the compiler will be fine and running the project will work, Xcode unfortunately still highlights the files in RED. To fix this, simply restart Xcode.

Then select the appropriate configuration and paste your Client ID and Secret into the required fields.

> These files are never committed to the repo so you don't need to worry about unstaging your commits. These are your local copies only!


## Apollo

If you see errors related to the Apollo framework, you either setup your environment to fix this or alternatively you can go to:  

`Project Settings > Build Phases`

Expand the script relative to Apollo and check the box:  

`[x] Run script only when installing`

## Pods

If you have an error related to Cocaopods, you will need to run `pod install` from the command line to fix.
