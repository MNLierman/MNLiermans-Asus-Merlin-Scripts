# MNLiermans-Asus-Merlin-Scripts
A growing collection of scripts that I've created for use on all routers, but specifically designed to improve performance, create additional features, and help my OCD while managing several networks that use Asus AX Routers. 

## INDEX
#### A somewhat helpful index of what these scripts do and why you might be interested in using them.

<br>

### Why?
To improve responsiveness, free up RAM, and make way for Docker containers to be able to run on the routers using their idle resources. Cleaning up the crap that Asus leaves on and running really does make a difference, and for reference, a full minimal install of Debian 10 takes up 100mb of RAM or less. Asus out of the box, with all features disabled or not setup, and Trend Micro EULA declined, uses nearly 200mb. Why, Asus? Been half temped to re-write rc.c and rc.h to allow for a smarter way of managing services and processes so that they are only started when needed. Ever since Windows 7, when Microsoft started this trend, this has been the defacto, but Asus is stuck in the past, and you will notice me point out this trend more and more. For another ex, they are still writing AsusWRT with linux kernel 4.1x from 2020 and Busybox version from the same year. 6 years ago. They are living in the past, and it's sad and disappointing to see Asus continue to do this; it makes me wonder what the hell they do all day, when they have 50-100 software engineers (or more) working on the home networking team, 40 hours a week, 4 weeks a month, 9.5 months out of the year (given 2.5 months vacation). They are doing what exactly? I support Asus, or I would be telling these clients I support that we don't support Asus and they need to replace this hardware. At some point, you just have to wonder. Anyway, this INDEX will list many of the scripts and projects I've created.

<br>

### One Last Thing: Creating Discussions
I am pretty responsive on GitHub, as I have many active projects going on, and among them are my ever growing collection of scripts. So if something doesn't work right or you have other questions, let me know in the comments and feel free to create a discussion here on GitHub. Please only create Issues after opening a discussion, and have logs and details ready to share if you are needing assistance.

<br>

### Auto Mount Entware Script: Mount-Ent.sh
Mount Entware Script (minimal version) for users of Entware, tested on a few Asus routers running Asuswrt Merlin NG. This script ensures that Entware is properly mounted on reboot. I had many problems with Entware not mounting correctly, so I created my own scripts for this. You can either call this script from post-mount, from services-start, or in your system's startup functions. If you need help or something isn't work, then as always, create a discussion item, I'm generally very responsive.

**Asus Merlin Users, Quick Install:** sh ```wget -O /jffs/scripts/Mount-Ent.sh https://raw.githubusercontent.com/MNLierman/MNLiermans-Asus-Merlin-Scripts/main/Mount-Ent.sh && chmod +x /jffs/scripts/Mount-Ent.sh && echo "/jffs/scripts/Mount-Ent.sh &" >> /jffs/scripts/post-mount```

<br>

### Improve Performance with Noatime & Nodiratime: BoutTime.sh and BoutTimev2.sh
By default, Linux mounts most filesystems with atime, diratime, and relatime options. These settings, which update the access time of files and directories, can be quite wasteful in terms of CPU and I/O resources. Even simple actions like searching for a file can trigger these unnecessary timestamp updates, leading to inefficiencies. Recognizing this, I decided to disable these options. Initially, I created a script (v1) in a hurry, which I share here for posterity and as an example of what the automatic script does. Later, I developed a more refined version (v2) that automatically iterates through all mounts and remounts them with noatime, nodiratime, and norelatime options.

While muunting with these options won’t make your router or system dramatically faster, it’s a worthwhile optimization to include in your startup routine. When combined with other optimizations, a startup script that implements several tweaks can lead to a noticeable improvement in system responsiveness.

Ultimately, my goal is to run Docker containers on my router during its idle time, and these optimizations are a step towards achieving that.

<br>

### More Uploads Soon...
