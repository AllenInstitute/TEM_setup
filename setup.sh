sudo -E sh <<EOF

# Update and Upgrade

apt-get update
apt-get -y upgrade

# Setup Certificates

apt-get install -y ca-certificates curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

# Setup Apt Sources

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu\
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list

curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    > /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Update and Install

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin nvidia-container-toolkit nvidia-driver-550-open

# Download .deb files

wget -O vscode.deb https://update.code.visualstudio.com/1.93.1/linux-deb-x64/stable
wget https://github.com/pulsar-edit/pulsar/releases/download/v1.120.0/Linux.pulsar_1.120.0_amd64.deb

# Install .deb files

DEBIAN_NOINTERACTIVE=1 dpkg -i vscode.deb Linux.pulsar_1.120.0_amd64.deb

# Download other software

wget https://www.ximea.com/downloads/recent/XIMEA_Linux_SP.tgz

# Install other software

tar -xzf XIMEA_Linux_SP.tgz
sh -c "cd package; ./install -pcie"

# Configure

cp TEM_setup/config/docker/daemon.json /etc/docker/

EOF

# Install PIP

wget -O- https://bootstrap.pypa.io/get-pip.py | python

# Install Python Packages

pip install pigeon-config

# Install Extensions

echo "ms-azuretools.vscode-docker
ms-python.debugpy
ms-python.python
ms-python.vscode-pylance
ms-vscode.cmake-tools
ms-vscode.cpptools
ms-vscode.cpptools-extension-pack
ms-vscode.cpptools-themes
ms-vscode.makefile-tools
twxs.cmake" | sed 's/^/--install-extension /' | xargs code

ppm install atom-material-syntax atom-material-syntax-light atom-material-ui auto-detect-indentation \
    autocomplete-python build build-make busy-signal language-cmake minimap

# Configure Extensions

cp TEM_setup/config/pulsar/config.cson ~/.pulsar/

# Create SSH key

ssh-keygen -f $HOME/.ssh/id_rsa -P ""
echo "Please add the following SSH key to your GitHub account (https://github.com/settings/ssh/new):"
echo
cat $HOME/.ssh/id_rsa.pub
echo
read -p "Press enter when complete." KEY

# Download Repositories

git clone git@github.com:AllenInstitute/TEM_config.git ~/Documents/TEM_config

# Reboot

reboot
