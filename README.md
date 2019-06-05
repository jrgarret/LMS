# Docker Container for Logitech Media Server
This Docker Container runs Logitech Media Server. It is based on the container created by larks. It was modified to run version 7.9.2 nightly of the server as well as opening the required port for Spotty plugin.

## Usage
You will find below examples of how to start the container.
### docker
```
docker run -d \
  --name=lms \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=America/Toronto \
  -p 9000:9000 \
  -p 9090:9090 \
  -p 3483:3483 \
  -p 3483:3483/udp \
  -p 4070:4070 \
  -v <path to music>:/music \
  -v <path to data>:/config \
  --restart unless-stopped \
  ptoulouse/lms
```
### docker-compose
```
version: '3'
services:
  lms:
    image: ptoulouse/lms
    container_name: lms
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Toronto
    ports:
      - 3483:3483
      - 3483:3483/udp
      - 9000:9000
      - 9090:9090
      - 4070:4070
    volumes:
      - <path to music>:/music
      - <path to data>:/config
    restart: unless-stopped
    # uncomment the following lines if using the MusicIP Container
    # depends_on :
    #   - musicip
```
## Parameters
|**Parameter**                |**Description**                                                 |
|-----------------------------|----------------------------------------------------------------|
| -p 9000:9000                | Port used to access the server WebUI.                          |
| -p 9090:9090                | Port used to access the server CLI.                            |
| -p 3443:3443                | Control channel between the players and the server.            |
| -p 3443:3443/udp            | For players/server discovery.                                  |
| -p 4070:4070                | Spotify port.                                                  |
| -e PUID=1000                | The server will run with that user ID.                         |
| -e PGID=1000                | The server will run with that group ID.                        |
| -e TZ=America/Toronto       | Specify your timezone.                                         |
| -v \<path to music\>:/music | Specify where your music files resides.                        |
| -v \<path to data\>:/config | Specify where the library, logs and preferences will be saved. |
