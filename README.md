# MNLiermans-Asus-Merlin-Scripts
A growing collection of scripts that I've created for use on all routers, but specifically designed to improve performance, create additional features, and help my OCD while managing several networks that use Asus AX Routers. 

## INDEX
#### A somewhat helpful index of what these scripts do and why you might be interested in using them.
<br>
<br>
### Why?
To improve responsiveness, free up RAM, and make way for Docker containers to be able to run on the routers using their idle resources. Cleaning up the crap that Asus leaves on and running really does make a difference, and for reference, a full minimal install of Debian 10 takes up 100mb of RAM or less. Asus out of the box, with all features disabled or not setup, and Trend Micro EULA declined, uses nearly 200mb. Why, Asus? Been half temped to re-write rc.c and rc.h to allow for a smarter way of managing services and processes so that they are only started when needed. Ever since Windows 7, when Microsoft started this trend, this has been the defacto, but Asus is stuck in the past, and you will notice me point out this trend more and more. For another ex, they are still writing AsusWRT with linux kernel 4.1x from 2020 and Busybox version from the same year. 6 years ago. They are living in the past, and it's sad and disappointing to see Asus continue to do this; it makes me wonder what the hell they do all day, when they have 50-100 software engineers (or more) working on the home networking team, 40 hours a week, 4 weeks a month, 9.5 months out of the year (given 2.5 months vacation). They are doing what exactly? I support Asus, or I would be telling these clients I support that we don't support Asus and they need to replace this hardware. At some point, you just have to wonder. Anyway, this INDEX will list many of the scripts and projects I've created.
<br>
<br>
### Mount Entware Script: Mount-Ent
Mount Entware Script (minimal version) for users of Entware, tested on a few Asus routers running Asuswrt Merlin NG. This script ensures that Entware is properly mounted on reboot. I had many problems with Entware not mounting correctly, so I created my own scripts for this. You can either call this script from post-mount, from services-start, or in your system's startup functions. If you need help or something isn't work, then as always, create a discussion item, I'm generally very responsive.

**Asus Merlin Users, Quick Install:** sh ```wget -O /jffs/scripts/Mount-Ent.sh https://raw.githubusercontent.com/MNLierman/MNLiermans-Asus-Merlin-Scripts/main/Mount-Ent.sh && chmod +x /jffs/scripts/Mount-Ent.sh && echo "/jffs/scripts/Mount-Ent.sh &" >> /jffs/scripts/post-mount```

<br>
<br>
### BoutTime.sh and BoutTimev2.sh
In the linux and busybox realm all mounts use by default atime, diratime, and relatime, these are all very sucessful CPU and IO wasters whose primary purpose is to update the access time of files and directories. So much as searching for another file can be enough to trigger this useless timestamp generation/update. It's very wasteful as I've mentioned, and so I set out to turn it off. The first version I leave here for posterity/example purposes on what the automatic script does, v1 script is also what I started with in a hurry. I then later created v2 which automatically iterates through all mounts and remounds them as noatime, nodiratime, and norelatime. It's not going to make your router, or other system, insanely faster, but it's something to add to the list of things that maybe you should have done at startup. In a collective manner, a startup script that runs through several optimizations should make a fairly modest improvement in responsiveness. My ultimate aim and goal, of course, is to be able to run Docker containers on my router during it's idle time.

### More Uploads Soon...
