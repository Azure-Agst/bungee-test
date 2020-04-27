# Example Bungeecord Project

BungeeCord is a useful software written in-house by the team at SpigotMC. It acts as a proxy between the player's client and the connected Minecraft servers. End-users of BungeeCord see no difference between it and a normal Minecraft server.

In this example, Bungeecord acts as a bridge between 2 temporary servers hosted on your PC, which you'll be able to swap between using the `/server` command.

## Example Run

### 0.) Clone the project files

This project is hosted using github, therefore you'll need git to download all of the files correctly. Install git, then run these commands where you want the repo to be cloned.

```bash
git clone https://github.com/Azure-Agst/bungee-test.git
cd bungee-test
git lfs fetch --all
```

*NOTE: if you don't want to install git, you may download an archive of the project [here](https://github.com/Azure-Agst/bungee-test/archive/master.zip), extract that to somewhere on your computer, and use that instead.*

### 1.) Setting up Servers

*NOTE: In this case, the configuration is already done, so there's no need to do anything.*

In order to get things going you'll need to set up the servers you'll be connecting between. In this project, there are two folders that house [Paper.io](https://papermc.io/) 1.15.2 servers: server1 and server2.

You'll need to run each server at least once and accept the EULA to create the config files you'll need to edit. Once these files are created, you can stop the servers by running the `stop` command in the console.

Edit these two settings located in `server.properties`:

```properties
server-port=[any open port between 25566-25576]
online-mode=false
```

The default port for Minecraft server use is port 25565. However, this port will be occupied by BungeeCord, so we configure our servers to use an unoccupied port, such as 25566, which BungeeCord will connect to upon request.

It is also imperative that you set the `offline-mode` setting to **FALSE**, as bungeecord essentially acts as a main-in-the-middle between the player and the server, breaking Mojang's typical authentication chain. However, we do later configure BungeeCord to authenticate with Mojang before rerouting our players, mitigiting the risk of illigitimate players (such as bots) from joining.

### 2.) Configure Bungeecord

*NOTE: In this case, the configuration is already done, so there's no need to do anything.*

Once your servers are configured, it's time to configure BungeeCord. Its executable is located in the root of the project, rather than a subfolder like the servers. Similar to the servers, you'll want to run BungeeCord at least once to have it generate config files.

The main config for BungeeCord is located in config.yml. The documentation for how to modify the config is located on [spigotmc.org](https://www.spigotmc.org/wiki/bungeecord-configuration-guide/). However, it may be more useful for unfamilliar server admins to use this project's provided config.example.yml as a template to follow for configuration, as it contains annotations that may make configuring easier.

Below are the essential settings to change, replacing `[servername]` with a codename of your choice given to your primary server, and `[server-port]` with its chosen port.

```yaml
listeners:
- query_port: 25565
  host: 0.0.0.0:25565
  priorities:
  - [servername]
online_mode: true
servers:
  [servername]:
    address: localhost:[server-port]
```

Note: Any comments located in config.yml will be deleted when BungeeCord starts up, so it's recommended you keep an annotated backup of your config, and copy the contents to config.yml when you want to implement them.

### 3.) Run the Servers and Connect

Once everything is set up, give everything a whirl! This project comes bundled with two scripts to get things started: one for Windows, one for Mac/Linux.

If on **Windows**, double click `bungee.bat` in the project root. This will open up 3 CMD windows, hosting the two example servers and bungeecord. Make exceptions to your firewall for Java if asked, and join the server in Minecraft 1.15.2 using the ip "localhost". You may kill these processes by closing the CMD windows.

If on **Mac/Linux**, ensure tmux is installed on your machine, and run the `./bungee.sh start` script in the project root. This will create 3 tmux sessions hosting the two example servers and bungeecord, then will automatically connect you to the bungeecord session. Join the server in Minecraft 1.15.2 using the ip "localhost". You may disconnect from the BungeeCord console session by pressing Ctrl-B, then D. From there, you can run `./bungee.sh stop` to kill the server processes.

### 4.) Test the Servers!

Once logged in, your player should default to "server_one" since it's your first time connecting. You can change to "server_two" by using the command `/server server_two`. From then on, whenever you log in, you should default to the server you were on last.

This behavior can be configured by modifying `config.yml`.

-----

*(c) 2020 Azure-Agst. All copyrights within this project are granted to their respective authors, unless specified otherwise.*
