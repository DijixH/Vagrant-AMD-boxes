sudo apt-get -y update
sudo apt-get -y install libvirt-bin qemu-kvm virt-manager virt-top libguestfs-tools bridge-utils
sudo apt-get -y install apt-transport-https ca-certificates curl
sudo apt-get install socat -y
sudo apt-get install -y conntrack
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker vagrant
systemctl start docker
sudo apt-get -y install wget
sudo wget https://github.com/kubernetes/minikube/releases/download/v1.25.1/minikube-linux-arm64
sudo chmod +x minikube-linux-arm64
sudo mv minikube-linux-arm64 /usr/bin/minikube
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
sudo systemctl enable docker.service
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo bash get_helm.sh
sudo rm get-docker.sh
sudo rm get_helm.sh