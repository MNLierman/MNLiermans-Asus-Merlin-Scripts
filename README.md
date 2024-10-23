# MNLiermans-Asus-Merlin-Scripts
A growing collection of scripts that I've created for use on all routers, but specifically designed to improve performance, create additional features, and help my OCD while managing several networks that use Asus AX Routers. 

## INDEX
#### A somewhat helpful index of what these scripts do and why you might be interested in using them.

<br>

### Why?
To improve responsiveness, free up RAM and CPU resources, add features, make my life easier, **and**, ultimately by acomplishing these, I can run Docker containers on routers using idle resources. Debloating, optimizing, and making more efficent Asus's software can make a huge difference. For reference, a typical install of Debian 10 uses 100MB of RAM or less, while an Asus router, even with all features disabled / not configured, and the Trend Micro EULA declined, uses nearly 200MB. ***Why, Asus?***

I’ve been tempted to rewrite rc.c/rc.h to manage services and processes more intelligently, starting them only when needed. This approach has been standard since Linux 2.6 with Systemd, and Windows 7 when Microsoft refined svchost. However, Asus seems stuck in the past; they continue to use outdated software and their ugly 10 year old web UI. They also haven't updated their linux kernel past 4.1x from 2019 (except for some security hot patches) and a BusyBox version from the same year. It’s disappointing to see Asus lagging behind, especially considering they have a large team of software engineers dedicated to home networking. Among many of the improvements and features of newer kernel versions, is huge improvements in USB 3.1, as well as performance and security.

Despite these issues, I continue to support Asus due to their historically high-quality products (I hope this hasn’t changed) and because many of my clients rely on Asus devices, including multiple routers in each of their offices. Overall, it’s frustrating to encounter such inefficiencies, which is my main driving motiviation to creating these improvements and scripts.

This INDEX will list many of the scripts and projects I’ve created to improve upon Linux for routers (and Asus/Merlin), address these issues I've discussed, and add conviences and features. I share these all with anyone. You are free to modify and redistribute anything I've uploaded, my only request is that you share any improvements you've made and give credit where appropriate. Occationally, there may be a type here and there, but nothing I upload has gone untested unless I've specifically stated such.

**Disclaimer: Use at your own risk! If my scripts turn your router into a molten heap of plastic, that’s on you. I provide these scripts with no warranty or promise that they’ll do anything other than potentially melt your router. Proceed with caution and a fire extinguisher nearby! 🧯** 

<br>

### One Last Thing: Creating Discussions
I am pretty responsive on GitHub, as I have many active projects going on, and among them are my ever growing collection of scripts. So if something doesn't work right or you have other questions, let me know in the comments and feel free to create a discussion here on GitHub. Please only create Issues after opening a discussion, and have logs and details ready to share if you are needing assistance.

<br>

### Auto Mount Entware Script: Mount-Ent.sh
Mount Entware Script (minimal version) for users of Entware, tested on a few Asus routers running Asuswrt Merlin NG. This script ensures that Entware is properly mounted on reboot. I had many problems with Entware not mounting correctly, so I created my own scripts for this. You can either call this script from post-mount, from services-start, or in your system's startup functions. If you need help or something isn't work, then as always, create a discussion item, I'm generally very responsive.

**Asus Merlin Users, Quick Install:** sh ```wget -O /jffs/scripts/Mount-Ent.sh https://raw.githubusercontent.com/MNLierman/MNLiermans-Asus-Merlin-Scripts/main/Mount-Ent.sh && chmod +x /jffs/scripts/Mount-Ent.sh && echo "/jffs/scripts/Mount-Ent.sh &" >> /jffs/scripts/post-mount```

<br>

### Improve Performance with Noatime & Nodiratime: BoutTime.sh and BoutTimev2.sh
By default, Linux mounts most filesystems with atime, diratime, and relatime options. These settings, which update the access time of files and directories, can be quite wasteful in terms of CPU and I/O resources. Even simple actions like searching for a file can trigger these unnecessary timestamp updates, leading to inefficiencies. Recognizing this, I decided to disable these options. Initially, I created a script (v1) in a hurry, which I share here for posterity and as an example of what the automatic script does. Later, I developed a more refined version (v2) that automatically iterates through all mount points and remounts them with noatime, nodiratime, and norelatime options.

While muunting with these options won’t make your router or system dramatically faster, it’s a worthwhile optimization to include in your startup routine. When combined with other optimizations, a startup script that implements several tweaks can lead to a noticeable improvement in system responsiveness.

Ultimately, my goal is to run Docker containers on my router during its idle time, and these optimizations are a step towards achieving that.

<br>

### More Uploads Soon...
 
