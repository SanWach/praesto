# CHANGELOG.md

## 1.1 (Vanilla)

## Changes:

- Replaced ping with curl for website availability checks, as many websites block ICMP (ping) requests. Using curl provides a more reliable status by checking HTTP/HTTPS accessibility.

- improved Online/Offline Messaging:
Logs the website as "online" if curl successfully connects over HTTP/HTTPS.
Logs "offline or not reachable via HTTP/HTTPS" if curl fails, providing a more accurate reflection of the website’s status.

- Added Timeout Limit: Set a 5-second timeout for curl checks to
avoid long waits on unresponsive sites.



