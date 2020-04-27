start cmd.exe /k "cd server1 && java -Xms1G -Xmx1G -jar server.jar --nogui"
start cmd.exe /k "cd server2 && java -Xms1G -Xmx1G -jar server.jar --nogui"
start cmd.exe /k "java -Xms512M -Xmx512M -jar BungeeCord.jar"