# This is just an out-of-the-box Pavlov VR server for Oculus Quest

Actually it contains two servers hehe, so that you know how to setup multiple servers using docker. RCON is enabled by default (check `RconSettings_*.txt`).

One server launches the CS 1.6 de_dust2 map, the other the de_dust2 from CS:GO.

## Why use Docker?

It is quick, and easy to launch, saves you time in most cases, and avoids polluting your VPS with the server's dependencies.

## I don't care, lets run it!

To run this you need to have docker and docker compose obviously. Install `docker compose` and not `docker-compose`. Just follow the official setup instructions.

Then you need to either completely disable you server's firewall (or if you are hosting locally, expose your computer using DMZ).
If you want to do it a safer way, then, for this setup I have where I am using ports: `7777, 8177, 7778, 8178, 9100 and 9101`:

1. Allow these ports for inbound connections (for TCP and UDP protocols)
2. Allow incoming ICMP requests
3. Allow Any ICMP and outbound connection on any port and protocol
4. Make sure your server has an IPv4 address, disable the IPv6 which is reported to cause issues with Pavlov VR as of version 1.0.19

Then just run `sh start.sh` as root on your server (ideally you have a VPS exclusively for this, don't run this in other important servers you have unless you know what you are doing!).

The servers should show up listed in [here](https://pavlovwiki.com/index.php/Setting_up_a_dedicated_server#Seeing_your_server_in_a_Master_List).

You can also connect to the RCON service through [here](https://pavlovservers.com/) or [here](https://pavlovhorde.com/).

## And for PCVR?

For PCVR, you will need to modify the `Dockerfile` where you see this line:

```
RUN ./steamcmd.sh +force_install_dir /home/steam/pavlovserver +login anonymous +app_update 622970 -beta shack validate +exit
```

You will need to replace it [with one of these](https://pavlovwiki.com/index.php/Setting_up_a_dedicated_server#Step_5:_User_SteamCMD_to_install_Pavlov). Everything else should work the same, except for the maps, which might not be compatible with PCVR (usually are). In case the maps are not compatible with PCVR, then just change their id in the `MapRotation` properties in the `*.ini` files you have in this project. These `*.ini` files are the server configurations.

**Quick Note** regarding `MapRotation` - you can add multiple lines of these to your `*.ini` files. This is done by taking the resource ID from the modio page ([https://mod.io/g/pavlov](https://mod.io/g/pavlov)), adding “UGC” in front of it and then adding that to the rotation. For example the map [gravity](https://mod.io/g/pavlov/m/gravity1) has a resource ID of 2773760 so the map ID to add to the server would be “UGC2773760”. When a match ends, the server will load the next map in the rotation.

```
MapRotation=(MapId="UGC2773760", GameMode="SND")
```

`SND` is the [game mode](https://pavlovwiki.com/index.php/Setting_up_a_dedicated_server#Game_Modes).

If for some reason the map doesn't load right, and the server defaults to other map (usually the Datacenter map), it means this map is not compatible with your platform type (Oculus VR, PCVR, ...).

### Don't forget!

Always check the [Official Wiki](https://pavlovwiki.com/index.php/Setting_up_a_dedicated_server) in case you are having issues or if you need more config information.