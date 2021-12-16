# not a script but a set of cmds to execute
#

docker run -it --rm -p 8080:2019 ubuntu /bin/bash
{
    apt update
    apt install -y curl
    apt install -y debian-keyring debian-archive-keyring apt-transport-https
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | tee /etc/apt/trusted.gpg.d/caddy-stable.asc
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
    apt update
    apt install -y caddy
}

# docker exec 8846027872c3 /bin/bash -c "curl -s localhost:2019/config/" {
# 	"apps": {
# 		"http": {
# 			"servers": {
# 				"example": {
# 					"listen": [":2015"],
# 					"routes": [
# 						{
# 							"handle": [{
# 								"handler": "static_response",
# 								"body": "Hello, world!"
# 							}]
# 						}
# 					]
# 				}
# 			}
# 		}
# 	}
# }
