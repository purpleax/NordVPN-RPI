# NordVPN-RPI
Setup NordVPN on Raspberry Pi


Setting up NordVPN on the Raspberry Pi

The process of setting up NordVPN on the Raspberry Pi is pretty straightforward. Once set up you can easily connect to your desired location by using specific ovpn files.

1. First, you will need to sign up to NordVPN if you haven’t already.

2. Open the terminal on the Raspberry Pi or use SSH to gain access.

3. Enter the following lines to update Raspbian to the latest packages.

sudo apt-get update
sudo apt-get upgrade

4. Next, install the OpenVPN package by entering the following command.

sudo apt-get install openvpn

5. Navigate to the OpenVPN directory by typing in the following command.

cd /etc/openvpn/

6. We now need to download the NordVPN ovpn files. This download can easily be done by entering the following into the terminal.

sudo wget https://nordvpn.com/api/files/zip

7. Next, unzip the file.

sudo unzip zip

8. To connect to NordVPN enter the following command.

sudo openvpn file_name

You will need to replace file_name with the file of the location you wish to connect to. You can use ls -l /etc/openvpn/ to see all the files. For example, I would pick an Australian server for the best speed.

sudo openvpn /etc/openvpn/au151.nordvpn.com.tcp443.ovpn

9. You will now need to enter your credentials. Once you have done that, you will be connected to the VPN server. You can test this by going to the NordVPN website and looking at the banner at the top.

10. If you wish to disconnect, then simply use ctrl+c on the keyboard. If this doesn’t work, then you can use the following command.

sudo killall openvpn

NordVPN Start at boot

If you wish to start your NordVPN service at boot, then the steps below will take you through everything you need to know.

1. First, we will need to save our username and password in a file.

sudo nano /etc/openvpn/auth.txt

2. In this file, add your username and password, both on separate lines.

username
password

3. Save and exit by pressing ctrl+x, then y and lastly enter.

4. Copy the ovpn file you wish to use at startup, simplify its name as well. For example:

sudo cp /etc/openvpn/au151.nordvpn.com.tcp443.ovpn /etc/openvpn/au151.conf

5. Now let’s edit this new file.

sudo nano /etc/openvpn/au151.conf

6. In here you will need to edit one line.

Find

auth-user-pass

Replace with

auth-user-pass auth.txt

7. Save and exit by pressing ctrl+x, then y, then enter.

8. Lastly, we need to setup OpenVPN to autostart and to use our file. Enter the following line to edit our config.

sudo nano /etc/default/openvpn

Find

#AUTOSTART="all"

Add above it

AUTOSTART="au151"

Replace au151 with the file name that we just created.

9. Save and exit.

10. Reboot and the Pi by entering the following command

sudo reboot

Now browse to either NordVPN or ipleak.net, and you should see that your IP is not your own. If it hasn’t changed, then the setup above isn’t working. Go back through the steps and check if you haven’t made any mistakes.
Preventing DNS Leaks

You probably also want to make sure that your DNS isn’t leaking your location so you will need to adjust dhcpcd configuration. It’s a simple fix as we will use the Cloudflare public DNS rather than our internet service providers DNS.

1. Firstly, load into the dhcpcd configuration file and update the following line.

Open

sudo nano /etc/dhcpcd.conf

Find

#static domain_name_servers=192.168.0.1

Replace with

static domain_name_servers=1.1.1.1

2. Save & exit the file.

3. Now reboot your Pi by entering the following command.

sudo reboot

4. Go to ipleak.net and check that your DNS is no longer leaking. If you’re still leaking. then you might want to look at this page on WebRTC requests for more information.
Troubleshooting

If you run into any issues setting this up then the tips below might help you out. Otherwise, I recommend posting your issue over at our forum.

    If you have your VPN auto-starting, then you can stop it by simply running the following command.

sudo systemctl start openvpn

    You can start it back up by replacing stop, with start.
    We’re keeping our credentials in plain text so make sure you keep your Pi secure. If an unauthorized user access this file they will be able to login to your VPN and any other service where you have reused that password.

If you rather run a VPN server out of your own home then a DIY Raspberry VPN server might take your fancy.

I hope by the end of this Raspberry Pi NordVPN tutorial you have everything working correctly. If you need further help, then be sure to head over to our forums.
