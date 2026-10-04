# Google Drive account setup

Each user authorizes their own account. This repository never includes an OAuth client secret, refresh token or rclone.conf. Your publishing identity (me@danimoya.com) does not select which Google Drive account is mounted.

1. Install rclone and fuse3 using `omarchy pkg add rclone fuse3`.
2. Sign in to [Google Cloud Console](https://console.cloud.google.com/) and select or create a project for your personal rclone use.
3. Enable **Google Drive API** under APIs & Services.
4. Configure the OAuth consent screen/Google Auth Platform: application name, support email, audience and developer contact. Use External for a personal account; Internal applies only within an eligible Workspace organization.
5. Configure Drive access scopes appropriate to the mount. Read-only access is enough for browsing; full Drive access permits writing and deleting. Follow rclone's current guide for the exact consent-screen fields.
6. Add the Google account you will use as a test user during testing.
7. Create an OAuth client with application type **Desktop app**. Keep its client ID and secret locally.
8. Run `rclone config`: create a new remote named `gdrive`, choose storage `drive`, and enter your own client ID and secret. Choose `drive.readonly` for a browsing-only pilot or `drive` for full read/write access. Leave service-account credentials unset for a normal personal login.
9. Choose browser authentication, select the intended Google account, and review the requested access. Choose Shared Drive only if that is your intended target; save the remote.
10. Run `rclone lsd gdrive:` to check access. Run `rclone config file` to locate the credentials file and restrict its permissions to your user. Never paste its contents into an issue.
11. Return to README.md to configure the user mount service and widget. Test with a dedicated folder first.

External OAuth apps left in Testing can require frequent reauthorization. Before relying on the mount, review the current Google consent/publishing requirements for your app and move it to Production where appropriate. This is separate from publishing an Omarchy plugin. Do not distribute one personal OAuth client to all plugin users.

The shared rclone client is being retired during 2026. The supported onboarding path here is bring-your-own OAuth client. Consult [rclone's Drive setup and client-ID guide](https://rclone.org/drive/#making-your-own-client-id) for current prompts and requirements.
