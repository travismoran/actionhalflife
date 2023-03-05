Docker Image for Action Half Life Dedicated Server
Required files: action folder from s3 with action mod + maps

Server Files/Maps:
http://s3.us-east-2.amazonaws.com/ahlfdl/

docker-compose.yml example
```
version: '3'
services:
  hlds:
    image: unbalancedmind/hlds
    ports:
      - "27000-27050:27000-27050/tcp"
      - "27000-27050:27000-27050/udp"
      - "1200:1200/udp"
      - "26900:26900/udp"
    volumes:
      - "/data/action:/root/hlds/action"
	  - "/data/config/server.cfg:/root/hlds/action/server.cfg"
      - "/data/config/mapcycle.txt:/root/hlds/action/mapcycle.txt"
```


Server/Host Setup(ubuntu 16.04 lts):
```
curl -fsSL https://get.docker.com | sh
systemctl enable docker
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
apt-get -y install unzip
unzip awscli-bundle.zip
apt install python-minimal
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
aws configure
mkdir /data
aws s3 sync s3://ahlfdl /data
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
curl -L https://github.com/andreaskoch/dcsg/releases/download/v0.4.0/dcsg_linux_amd64 > /usr/local/bin/dcsg
chmod +x /usr/local/bin/dcsg
```

