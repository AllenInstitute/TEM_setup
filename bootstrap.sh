mkdir ~/setup
cd ~/setup
wget -O TEM_setup.zip https://github.com/AllenInstitute/TEM_setup/archive/refs/heads/master.zip
unzip TEM_setup.zip
mv TEM_setup-master TEM_setup
sh TEM_setup/setup.sh
