
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install openvpn

cd /etc/openvpn/
sudo wget https://nordvpn.com/api/files/zip
sudo unzip zip

#FileName is the location file (ovpn file) from Nord (a directory listing will show the files)
sudo openvpn "file_name"

sudo openvpn /etc/openvpn/au151.nordvpn.com.tcp443.ovpn

