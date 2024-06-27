---
title: 2.4 GHz WiFi Trouble? Disable Bluetooth.
date: 2023-06-22T19:20:42+00:00
---

---

**tl;dr:** Bluetooth and 2.4 GHz WiFi don't play nicely together. Here's how I figured it out.

---

I have both 2.4 and 5 GHz networks running in my home. I have found that my personal laptop has
a _really_ hard time scanning for / connecting to 2.4 GHz networks. It'll eventually connect, but
it takes up to a few minutes to find the 2.4 GHz network and work out a connection.

I got tired of it and started searching the Interwebz.

At some point in my web searches, I learned that I'm running an Intel wireless network card using
the built-in Linux kernel `iwlwifi` driver. _Here's partial output of `lspci -k`:_

```
02:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
    Subsystem: Intel Corporation Wireless 8265 / 8275
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi
```

I also learned about the various config parameters for this driver. _Here's partial output of
`modinfo iwlwifi`:_

```
parm:           swcrypto:using crypto in software (default 0 [hardware]) (int)
parm:           11n_disable:disable 11n functionality, bitmap: 1: full, 2: disable agg TX, 4: disable agg RX, 8 enable agg TX (uint)
parm:           amsdu_size:amsdu size 0: 12K for multi Rx queue devices, 2K for AX210 devices, 4K for other devices 1:4K 2:8K 3:12K (16K buffers) 4: 2K (default 0) (int)
parm:           fw_restart:restart firmware in case of error (default true) (bool)
parm:           nvm_file:NVM file name (charp)
parm:           uapsd_disable:disable U-APSD functionality bitmap 1: BSS 2: P2P Client (default: 3) (uint)
parm:           enable_ini:0:disable, 1-15:FW_DBG_PRESET Values, 16:enabled without preset value defined,Debug INI TLV FW debug infrastructure (default: 16)
parm:           bt_coex_active:enable wifi/bt co-exist (default: enable) (bool)
parm:           led_mode:0=system default, 1=On(RF On)/Off(RF Off), 2=blinking, 3=Off (default: 0) (int)
parm:           power_save:enable WiFi power management (default: disable) (bool)
parm:           power_level:default power save level (range from 1 - 5, default: 1) (int)
parm:           disable_11ac:Disable VHT capabilities (default: false) (bool)
parm:           remove_when_gone:Remove dev from PCIe bus if it is deemed inaccessible (default: false) (bool)
parm:           disable_11ax:Disable HE capabilities (default: false) (bool)
parm:           disable_11be:Disable EHT capabilities (default: false) (bool)
```

Well hey, what's this `bt_coex_active:enable wifi/bt co-exist` business? Some web searching led me
to [this very old SuperUser answer](https://superuser.com/a/1118989):

> The 2.4 GHz Wifi band and bluetooth spectrums have a great deal of overlap and can conflict with
> each other

So apparently you can configure your driver to not allow Bluetooth and 2.4 GHz WiFi to be activated
simultaneously, which can be important because their operating frequencies overlap.

I don't use (or like) Bluetooth anyway, so instead of messing with my driver, I just decided to turn
Bluetooth off permanently.

```
sudo systemctl disable --now bluetooth
```

Problem solved.
