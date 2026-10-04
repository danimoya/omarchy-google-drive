# Google Drive for Omarchy

Google Drive mount status, transfer activity, and file access from the Omarchy bar.

By **Daniel Moya** — [@danimoya](https://github.com/danimoya) · me@danimoya.com

**Development snapshot (0.1.0-dev).** Prepared for public development; not yet a supported release or approved directory listing. See [release checklist](RELEASE-CHECKLIST.md). This code does not change your running desktop merely by being cloned.

## Obtain the plugin

Once this repository is public:

```sh
omarchy plugin add https://github.com/danimoya/omarchy-google-drive.git
```

Choose not to enable it until completing the setup below. Local source validation:

```sh
omarchy plugin validate .
```

## Development setup

Dependencies: Omarchy Quattro, Quickshell, rclone, fuse3, bash, jq, curl, NetworkManager/nmcli, iproute2, coreutils, findutils, awk, grep, sed, systemd and xdg-utils.

1. Complete [Google account setup](ACCOUNT-SETUP.md) to create a private `gdrive:` remote.
2. Ensure `~/Drive` is empty and unused. The service mounts your remote there; it does not create a complete offline replica.
3. Review `systemd/rclone-gdrive.service`. This development snapshot still exposes unauthenticated RC on loopback port 5572; resolve the RC release checklist item before broad distribution.
4. If no service with this name already exists, install the unit and start it explicitly:

   ```sh
   mkdir -p ~/.config/systemd/user
   test ! -e ~/.config/systemd/user/rclone-gdrive.service &&
     install -m 644 systemd/rclone-gdrive.service ~/.config/systemd/user/
   systemctl --user daemon-reload
   systemctl --user enable --now rclone-gdrive.service
   ```

5. Enable `danimoya.gdrive` after the plugin is installed. Left-click opens the mount; right-click stops/starts it; middle-click refreshes directories.
6. Verify using a dedicated test folder before normal use. Cached files may remain available offline; uncached content requires connectivity. Changes through the mount act on Google Drive.

## Removal

Wait for pending uploads to finish. Disable/stop `rclone-gdrive.service`, remove the user unit only if installed by this project, then run `systemctl --user daemon-reload`. Remove the plugin using `omarchy plugin remove danimoya.gdrive`. Retain rclone configuration and caches until you have confirmed all pending data is uploaded. Do not delete files through the mount as an uninstall step.

## Preparation changes

Added a native bar-widget manifest and QML entry point. Click actions use argument arrays and an explicit toggle branch. Recent file modification time is labelled “Recent activity”, not “Last sync”; the recovery tooltip now describes the actual stop/start behavior.

## Publishing and attribution

See [publisher account setup and directory workflow](PUBLISHING.md) and the [validation record](VALIDATION.md).

One root manifest identifies this plugin as `danimoya.gdrive`. [Marketplace submission draft](MARKETPLACE-SUBMISSION.md) is intentionally incomplete until release checks pass. Submit the same public repository to [Omarchy Plugins](https://plugins.omarchy.org/publish.html) and [Omahub](https://omahub.dev/submit).

Source provenance and upstream credits are recorded in [NOTICE.md](NOTICE.md). MIT license; see [LICENSE](LICENSE). Report reproducible issues through this repository, including Omarchy and Hyprland versions and logs with personal information removed.
