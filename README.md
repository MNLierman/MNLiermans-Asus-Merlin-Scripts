# MNLierman's Wireless Router Scripts
## Scripts for Routers, Including Those Running Asus WRT, Merlin, and DDWRT
I'm sharing my growing collection of scripts I've written for wireless routers, including those running DDWRT and Asus / Merlin, they can be utilized on nearly any router. These scripts are designed to enhance performance, add new features, and make life easier and more enjoyable.

**Disclaimer: Use at your own risk! I may have put a lot of effort and time into what I've shared, but if my scripts turn your router into a molten heap of plastic, that’s on you. I provide these scripts with _zero_ warranties or promises. Proceed with caution and a fire extinguisher nearby! 🧯** 

#### Further below I've provided a somewhat helpful index of what each of these scripts do and why you might be interested in using them.

<br>

## ℹ️ Introduction

### Why?
As an IT professional, I manage a lot of different hardware (Asus included)( for clients, as well as personally my self, and I enjoy sharing with the community at large the things I've created/modified that I find benificial. The goal is to enhance responsiveness, free up RAM and CPU resources, and add features, ultimately simplifying management. By achieving these improvements, I can transfer responsibility of somee apps, containers, and services from servers / Docker setups to the be handled by the free resources of the routers, thereby distributing the network load and ensuring smoother operation. This approach leverages the idle resources of the routers to run applications and services that would otherwise be handled by other systems. Optimizing and debloating Asus’s software can significantly improve performance. Just for reference, a typical Debian 11 installation uses 100MB of RAM or less, while an Asus router, even with all features disabled and the Trend Micro EULA declined, uses nearly 200MB.  ***Why, Asus?***

I’ve been tempted to rewrite rc.c/rc.h to manage services and processes more intelligently, starting them only when needed. This approach has been standard since Linux 2.6 with Systemd, and Windows 7 when Microsoft refined svchost. However, Asus seems stuck in the past; they continue to use outdated software and their ugly 10 year old web UI. They also haven't updated their linux kernel past 4.1x from 2019 (except for some security hot patches) and a BusyBox version from the same year. It’s disappointing to see Asus lagging behind, especially considering they have a large team of software engineers dedicated to home networking. Among many of the improvements and features of newer kernel versions, is huge improvements in USB 3.1, as well as performance and security.

Despite these issues, I continue to support Asus due to their historically high-quality products (I hope this hasn’t changed) and because many of my clients rely on Asus devices, including multiple routers in each of their offices. Overall, it’s frustrating to encounter such inefficiencies, which is my main driving motiviation to creating these guides and scripts.

This INDEX will list many of the scripts and projects I’ve created to improve upon Linux for routers (and Asus/Merlin); they are meant to address these issues I've discussed, and add conviences and features. I share these all with anyone. You are free to modify and redistribute anything I've uploaded, my only request is that you share any improvements you've made and give credit where appropriate. Occationally, there may be a typo here and there, but nothing I upload has gone untested unless I've specifically stated such.

###### **Disclaimer: Use at your own risk! I may have put a lot of effort and time into what I've shared, but if my scripts turn your router into a molten heap of plastic, that’s on you. I provide these scripts with _zero_ warranties or promises. Proceed with caution and a fire extinguisher nearby! 🧯**

<br>

### Creating Discussions
I am pretty responsive on GitHub, as I have many active projects going on, including my ever growing collection of scripts. **If something doesn't work right or you have other questions, let me know in the comments and feel free to create a discussion item here on GitHub.** However, please only create Issues after opening a discussion, and have logs and details ready to share if you are needing assistance.

### Thank You to the Communtiy
To the many communities and forums out there that share their discoveries with integrated devices (including Asus and router related forums)! These places are full of resources for anyone looking to add value to their systems. Some of the scripts and resources I've shared here are modifications / improvements of resources originally shared elsewhere. When the original work is not my own, I've attempted to make this clear in the comments.

<br>

## ⌨️ Scripts Index

### Auto Mount Entware Script: Mount-Ent.sh
Mount Entware Script (minimal version) for users of Entware, tested on a few Asus routers running Asuswrt Merlin NG. This script ensures that Entware is properly mounted on reboot. I had many problems with Entware not mounting correctly, so I created my own scripts for this. You can either call this script from post-mount, from services-start, or in your system's startup functions.

**Asus Merlin Users, Quick Install:** sh ```wget -O /jffs/scripts/Mount-Ent.sh https://raw.githubusercontent.com/MNLierman/MNLiermans-Asus-Merlin-Scripts/main/Mount-Ent.sh && chmod +x /jffs/scripts/Mount-Ent.sh && echo "/jffs/scripts/Mount-Ent.sh &" >> /jffs/scripts/post-mount```

<br>

### Improve Performance with Noatime & Nodiratime: BoutTime.sh and BoutTimev2.sh
By default, Linux mounts most filesystems with atime, diratime, and relatime options. These settings, which update the access time of files and directories, can be quite wasteful in terms of CPU and I/O resources. Even simple actions like searching for a file can trigger these unnecessary timestamp updates, leading to wasted system resources. Recognizing this, I decided to disable these options. Initially, I created a script (v1) in a hurry, which I share here for posterity and as an example of what the automatic script does. Later, I developed a more refined version (v2) that automatically iterates through all mount points and remounts them with noatime, nodiratime, and norelatime options.

While muunting with these options won’t make your router or system dramatically faster, it’s a worthwhile optimization to include in your startup routine. **When combined with other optimizations, a startup script that implements several tweaks can lead to a noticeable improvement in system responsiveness.**

<br>

### Network Performance Improvement Scripts

**Net Optimize:** Script that optimzies the routers networking functions. This will force the router to utilize it's memory a little more efficently for packet receive/send, with buffers large enough that on a busy home network, playing high-bandwidth games and streaming movies at the same time doesn't result in packet drop due to too small of buffers and a packet qeueig running on just 1 ofr the cores (this is the default).

**Nvrmset:** Similar to the Net Optimize script, this optimzies the nvram settings that the router relies upon when booting it's config and supporting the features we all use every day. Be sure to look through this one if you want to use it. I've provided comments on things you may wnat to change or adjust. We've had issues at my shop, and our clients erxperienced this too, a great difficutly with some devices disconnecting and reconnecting, some of the helpful settings for this "feature" is in the nvrmset script, which is why you will want to review if they are the right values you want for your network.

**SetMTU:** Loops through all network interfaces and attempts to set physical devices to 2500 and virtual devices to 5000. 1500 bytes per packet was designed with the 90s and early 2000s in mind. As we dive into 2025, I think it's important that we push the bar higher. While 9000 MTU is adventerous, and I've seen Google recommend this experimental MTU in their Cloud VPS systems in some documentation, I think that may be a little too high for a default MTU. 2500 is a significant improvement to 1500, as long as you have pmtu enabled (which Asus uses).

<br>

### Misc Performance Improvement Scripts
Scripts that I decided won't be getting their own heading.
<br>
More to come...

<br>

## ★ Solving Bugs in Wireless Routers

### Disconnect & Reconnect / Auth & Deauth Looping Bug
At my shop and on the routers I manage, we experienced significant issues with devices repeatedly connecting and disconnecting. After extensive research and examining the AsusWrt source code, I believe I identified the cause and developed a solution. (I will update this later with references and links to the relevant source code sections for Asus/Merlin to address.)

The issue stems from the Roaming Assistant, which is designed to disconnect devices with low RSSI (signal strength) so they can connect to a closer router. However, Asus made changes that force this feature on, even when it detects a non-Mesh network. A specific build parameter forces Roaming Assistant to always run, and a commit by an Asus engineer, which went unnoticed, commented out code that previously prevented Roaming Assistant from running unnecessarily.

As a result, in the past 12 months (as of October 2024), Roaming Assistant ignores the RSSI settings in the Web UI, defaulting to a hard-coded value of -70 (+/- 10). This means that if a device’s RSSI reaches -60, Roaming Assistant disconnects it. Without a closer router (if you only have 1), the device reconnects, only to be disconnected again, creating an endless loop.

There are a few solutions, but the best one involves changing the NVRAM variables to longer timeouts and sending a suspend signal to the Roaming Assistant process. This inspired the creation of the ProcSuspender script, which runs every 10 minutes via cron to suspend problematic Asus services and processes that consume CPU resources. Suspending processes is the safest solution, as stopping or killing them only works for 5-10 seconds before Watchdog and RC_Service restart them.

Script will be uploaded soon.

<br>

### More Uploads Soon...
 
