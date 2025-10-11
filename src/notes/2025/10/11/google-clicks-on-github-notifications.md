---
title: Google clicks on GitHub notifications for you
date: 2025-10-11T13:59:25+00:00
---

At work I use GitHub notifications heavily. However lately I've been noticing a strange
/ annoying phenomenon: GitHub notifications randomly mark themselves as "read" without
me looking at them. This is actually quite disruptive to my workflow, since I use the
"read" status to determine what things haven't yet gotten my attention.

After a long time trying to figure out what the problem was, I finally found [a GitHub
discussion](https://github.com/orgs/community/discussions/144794) including people who
experience the same issue. Apparently this has been happening for a while, but for some
reason I haven't been falling victim to it until now.

In short: I have notification emails set up in GitHub. Notification emails contain
tracking pixels. Once a tracking pixel is downloaded, the notification is marked as
read. Since Gmail[^1] automatically downloads email contents like tracking pixels _upon
reciept_ (rather than when opening the email), notifications will often be marked as
read before I ever get the chance to see them.

This is a good example of a problem that's hard to troubleshoot, but easy to fix. You
have two options:

* Disable email notifications at <https://github.com/settings/notifications>.
* Get an email provider that doesn't prefetch all your email contents.

[^1]: sadly, my _work_ email provider 😭
