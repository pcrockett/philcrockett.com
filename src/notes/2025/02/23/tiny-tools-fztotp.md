---
title: "Tiny Tools: fztotp"
date: 2025-02-23T18:32:10+00:00
---

_This is my first [Tiny Tools](/notes/2024/06/29/tiny-tools/) post._

`fztotp` ("fuzzy TOTP") is a relatively simple tool built on top of [`fzf`][fzf] (as
are all of my most useful scripts) and [`ykman`][ykman]. I'm a little biased, but
this is the best [TOTP][totp] authenticator app I have ever used (though it's only for
[Yubikey][yubico]).

You can find the script [on GitHub][project-page].

Its job is quite simple:

1. Show the list of TOTP auth credentials you have stored in your Yubikey, in an `fzf`
   user interface
2. allow the user to fuzzy-select one of the credentials in the list, and then
3. copy the TOTP code for that site to your clipboard (if you have
   [`xsel`][xsel] installed).

This enables me to get through multi-factor auth dialogs in just a few keystrokes. All
with just \~50 lines of code.

If you have `fzf` and `ykman` installed already, you can install `fztotp` on a Linux
machine with:

```bash
curl -SsfL https://philcrockett.com/yolo/v1.sh \
    | bash -s -- fztotp
```

{% mastodonCommentsSection "<https://fosstodon.org/@pcrock/114058031613011373>" %}

[fzf]: https://github.com/junegunn/fzf

[ykman]: https://docs.yubico.com/software/yubikey/tools/ykman/intro.html

[totp]: https://en.wikipedia.org/wiki/Time-based_one-time_password

[yubico]: https://www.yubico.com/

[project-page]: https://github.com/pcrockett/rush-repo/blob/main/fztotp/fztotp

[xsel]: https://github.com/kfish/xsel
