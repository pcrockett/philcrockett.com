---
layout: layout.liquid
title: Links
---

The following is a list of things I think are awesome and worth sharing:

## Software and Services

### Eleventy

{% newTabLink "https://www.11ty.dev/" %}

A simple static site generator which I personally find to be more intuitive than
{% newTabLink "Hugo" "https://gohugo.io/" %} or {% newTabLink "Jekyll" "https://jekyllrb.com/" %}. The source for this
website can be found {% newTabLink "on GitHub" "https://github.com/pcrockett/philcrockett.com" %}.

### Tailscale

{% newTabLink "https://tailscale.com/" %}

&ldquo;A secure network that just works.&rdquo; A mesh VPN that gives your devices the ability to automatically find
each other and establish direct encrypted connections when possible. Relies on the
{% newTabLink "WireGuard protocol" "https://www.wireguard.com/" %}. I use it extensively, including some of the less
documented features like {% newTabLink "exit nodes" "https://github.com/pcrockett/tailscale-container" %} and
{% newTabLink "subnet routers" "https://tailscale.com/kb/1019/subnets/" %}. It&rsquo;s a networking Swiss army knife.

### Standard Notes

{% newTabLink "https://standardnotes.org/" %}

A great note-taking app that syncs notes between devices. End-to-end encrypted, runs on all major OSes, 100% open
source (both server and client code), self-hostable, and the team behind it has a really admirable business model.
Downside: It&rsquo;s developed in JavaScript, and when you have thousands of notes, it really bogs down (especially on
Android). Currently looking for a replacement.

### My Bash Script Template

{% newTabLink "https://gist.github.com/pcrockett/8e04641f8473081c3a93de744873f787" %}

Bash is a terrible language. But it&rsquo;s not so bad if you&rsquo;re using {% newTabLink "ShellCheck" "https://github.com/koalaman/shellcheck" %}
and you have a nice template to start from. I copy / paste / modify this script any time I want to automate something
new in Linux. I also use it for things like syntax reminders, and I update it periodically when I discover something
new and useful.

## Operating Systems

### Desktop Linux Distros

* {% newTabLink "Fedora Silverblue" "https://docs.fedoraproject.org/en-US/fedora-silverblue/#introduction" %}
* {% newTabLink "Pop!" "https://pop.system76.com/" %}
* {% newTabLink "Arch" "https://archlinux.org/" %}

These three operating systems are my current favorites, and I can never decide which one I want to keep installed on my
laptop. Silverblue is an immutable OS (the future!), Pop is a joy to use when I actually want to get stuff done (amazing
keyboard-driven UI), and Arch is great for tinkering.

### GrapheneOS

{% newTabLink "https://grapheneos.org/" %}

A privacy and security-oriented fork of Android. For a while I used {% newTabLink "/e/OS" "https://e.foundation/" %},
however I discovered that /e/ is over-extended. They try to support too many phone models and too much software, with
not enough resources. This leads to low-quality outdated software, which is frustrating and insecure. Graphene is the
opposite; They only support recent Pixel models, meaning they have the resources to keep up, and they produce an
extremely polished, high-quality OS.

## Devices

### Raspberry Pi

{% newTabLink "https://www.raspberrypi.org/" %}

A great little computer that's affordable and surprisingly powerful. Great for tinkering and learning, as well as
running a tiny efficient home server or simple desktop PC. I have a couple Pis in a couple different locations running
{% newTabLink "Arch ARM" "https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4" %} and
[Tailscale](#tailscale). They are subnet routers and exit nodes, giving me access to a lot of things no matter where I
am in the world.

## Security

### Security Planner

{% newTabLink "https://securityplanner.org/" %}

Answer a few questions, and get a simple plan for improving your privacy and security, with links to useful resources
for further education. Very user-friendly, great for people ranging from aging parents to journalists.

### Qubes OS

{% newTabLink "https://www.qubes-os.org/" %}

A high-security operating system that uses virtual machines to compartmentalize various areas of life. Often used by
security researchers or other people in high-risk situations. I used it for a few months and was really impressed,
though it ended up being too sluggish on my aging laptop.

## Information

### AllSides

{% newTabLink "https://www.allsides.com/unbiased-balanced-news" %}: News aggregation website that seeks to organize
articles based on their bias: left, right, or center. &ldquo;We expose people to information and ideas from all sides
of the political spectrum so they can better understand the world — and each other.&rdquo;

### Lobsters

{% newTabLink "https://lobste.rs/" %}

Technology link aggregation site similar to Hacker News, but instead of focusing on entrepreneurship, the focus tends
more toward free and open source software.

## Fun

### Screeps 

{% newTabLink "https://screeps.com/" %}

MMO sandbox game for programmers. Like a real-time strategy game, but it's constantly running even when you're not
logged in, and all your units are controlled by code that you write. It's also a good opportunity to improve your
{% newTabLink "TypeScript" "https://www.typescriptlang.org/" %} skills.
