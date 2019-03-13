# Getting Started With GitHawk
First off, welcome to the GitHawk community! 👋

This guide will walk through the setup process required in order to get the GitHawk app up and running.

## 1a. Fork the repo
Head to [the GitHawk repo](https://github.com/GitHawkApp/GitHawk) and tap the Fork button located at the top right of the screen. 
## 1b. Cloning the repo
1. Create or navigation to a folder/directory where you’ll store the GitHawk project.

	Example: `mkdir ./desktop/GitHawkApp/`

2. In terminal clone the repo using: `git clone https://github.com/<YourGithubUsername>/GitHawk.git`

## 2. Installing

```bash
cd GitHawk
bundle
bundle exec pod install
npm install
```

## 3. Setting up OAuth for login

To be able to log in during development, you'll need a Client ID and Client Secret.
To get these, [register](https://github.com/settings/applications/new) a new OAuth application on GitHub.

### Registering

Here, you will need to fill in an Application name, Homepage URL and Authorization callback URL.
Make sure the Authorization callback URL is set to `freetime://`. The others can be filled in as you wish.

You will be redirected to the application page where you can access your Client ID and Client Secret.

To add the Client ID and Client Secret to the App, follow these steps:

1. In Xcode, go to `Product` (in the Menu bar) > `Scheme` > `Manage Schemes...`
2. Select `Freetime-AppCenter` and click the cog.
3. Click on `Duplicate`.
4. Uncheck the `Shared` checkbox.
5. Select `Copy of Freetime-AppCenter` and click on `Edit...`
6. Go to `Run` > `Arguments`
7. Add your Client ID (`GITHUB_CLIENT_ID` as key) and Client Secret (`GITHUB_CLIENT_SECRET`) to the Environment Variables.

The copy of the scheme is to avoid commiting your private environement variable to the repository.

>   Checkpoint: At this point you should be able to successfully build the app on the simulator

🎉 The project is officially set up! 🎉 

At this point you can begin making changes and testing on your simulator.
If you would like to test on a physical device, one more step remains.

## 4. Setting up code-signing (With automatic code-signing)

> ⚠️ **1. This step is only if you would like to test/run the app on your physical device 2. This step changes the bundleID and groupID, keep in mind when you commit to leave these changes out**

1. Open the Xcode workspace called: `Freetime.xcworkspace`
(`open Freetime.xcworkspace`)


**Setting up bundle and group ID’s**
- - - -

2. Open the projects settings  ![](./Design/projectIcon.png).
On the left there under Targets should be:

	* Freetime
	* FreetimeTests
	* FreetimeWatch
	* FreetimeWatch Extension

3. Under each of these targets make sure you're in the _General_ tab. **Change the team** to the team associated with your Apple Developer Account and switch the bundle ID’s like so:

	**Freetime**: *com.xxxx.freetime* ➡️
	*com.`<yourRegularBundleName>`.freetime*

	**FreetimeWatch**: *com.xxxx.freetime.watchkitapp* ➡️
	*com.`<yourRegularBundleName>`.freetime.watchkitapp*

	**FreetimeWatch Extension**: *com.xxxx.freetime.watchkitapp.watchkitextension* ➡️ *com.`<yourRegularBundleName>`.freetime.watchkitapp.watchkitextension*

4. Under the _Capabilities_ tab change the App Group ID’s like so (Does not apply to FreetimeTests):

	1.  Remove *group.com.xxxx.freetime*
	2.  Create new group ID (Click plus in the bottom left) and name it *group.com.`<yourRegularBundleName>`.freetime*

	> *Note: All group ID’s must be the same (This is what groups them!)*

	> Checkpoint: All errors should have disappeared (You should still not be able to build successfully though)


**Setting up plists**
- - - -

4. In the projects navigation panel open the folder named FreetimeWatch.

1.  Open the `info.plist`
2.  Change `WKCompanionAppBundleIdentifier` from *com.xxxx.freetime* ➡️ the Freetime Target Bundle ID (*com.`<yourRegularBundleName>`.freetime*)
5. Back in the projects navigation panel open the folder FreetimeWatch Extension
1.  Open `info.plist`
2.  Expand `NSExtension` > `NSExtensionAttributes`
4.  Change `WKAppBundleIdentifier` from *com.xxxx.freetime.watchkitapp* ➡️ the FreetimeWatch Target Bundle ID (*com.`<yourRegularBundleName>`.freetime.watchkitapp*)

>   Checkpoint: At this point you should be able to successfully build the app on your physical device


Build and Code away!
