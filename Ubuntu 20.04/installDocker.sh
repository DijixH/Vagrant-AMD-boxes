sudo apt-get update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker vagrant
sudo rm get-docker.sh
sudo systemctl enable docker
sudo systemctl start docker