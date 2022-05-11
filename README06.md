# How to setup a new Droplet on Digital Ocean

1. Create Dropplet
Docker on Ubuntu, 2GB

2. Copy IP of Droplet to GitHub secret DIGITAL_OCEAN_IP_ADDRESS

3. SSH into the Droplet instance
$ ssh root@<IP OF DROPLET>

3.1. Next, generate a new SSH key. Save the key to /root/.ssh/id_rsa and don't set a password.
$ ssh-keygen -t rsa

3.2. To set up passwordless SSH login, copy the public key over to the authorized_keys file and set the proper permissions:
$ cat ~/.ssh/id_rsa.pub
$ vi ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/id_rsa

3.3. Copy the contents of the private key:
$ cat ~/.ssh/id_rsa

3.4. Copy private key to the GitHub secret PRIVATE_KEY
