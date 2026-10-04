# Before v0.1.0

Status: development preparation; no stable release or directory listing is claimed.

- [ ] Replace the unauthenticated localhost RC endpoint with a private Unix socket or authenticated endpoint, and update every client.
- [ ] Add a non-destructive setup/removal command, remote and mount-path settings, dependency checks, and port/socket conflict detection.
- [ ] Test OAuth setup, read/write operations, offline recovery, expired credentials, queued uploads, and clean shutdown using a dedicated test folder.
- [ ] Run the widget in a real Omarchy session, capture a preview without private filenames, and verify current stable Omarchy compatibility.
- [ ] Run `omarchy plugin validate .` and QML checks against the target shell.
- [ ] Verify installation, upgrade, disable, and removal in a disposable user session.
- [ ] Add a real preview image and record exact tested Omarchy/Hyprland versions.
- [ ] Review tracked files for account data and preserve upstream license notices.
- [ ] Set the release version only after these checks pass; tag the tested commit.
- [ ] Submit the repository to both directories and record submission links.

See README.md for the present development setup. Passing manifest validation alone does not establish runtime correctness.
