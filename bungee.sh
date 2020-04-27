#/bin/bash
# Bungeecord Util
# (c) 2020 Azure-Agst

function helptext () {
	echo "Usage: ./bungee.sh [argument]"
	echo "   start - Starts the server"
	echo "   stop - Stops the server"
	echo -e "   help - Displays this helptext\n"
}

function start () {
	echo "Starting servers..."
	tmux new -d -s server1 "cd server1 && java -Xms1G -Xmx1G -jar server.jar"
	tmux new -d -s server2 "cd server2 && java -Xms1G -Xmx1G -jar server.jar"
	
	echo "Waiting on servers..."
	sleep 10s

	echo "Starting BungeeCord..."
	tmux new -d -s bungee "java -Xms512M -Xmx512M -jar BungeeCord.jar"

	echo "Attaching to session 'bungee'..."
	tmux attach -t bungee
}

function kill () {
	echo "Killing servers..."
	tmux kill-session -t server1
	tmux kill-session -t server2

	echo "Killing BungeeCord..."
	tmux kill-session -t bungee

	echo "Done!"
}

case $1 in
	start)
		start
		;;

	stop)
		kill
		;;

	help)
		echo "Bungeecord Util Script"
		echo "(c) 2020 Azure-Agst"
		helptext
		;;

	*)
		if [ -z $1 ]; then
			echo -e "Missing argument!\n"
		else
			echo -e "Unknown argument: '$1'\n"
		fi
		helptext
		;;
esac
