first time on the new droplet:

ssh root@159.223.21.84

Next, generate a new SSH key:
Save the key to /root/.ssh/id_rsa and don't set a password.

$ ssh-keygen -t rsa

copy the public key over to the authorized_keys file and set the proper permissions:

$ cat ~/.ssh/id_rsa.pub
$ vi ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/id_rsa

Copy the contents of the private key:

$ cat ~/.ssh/id_rsa

Exit from the SSH session, and then set the key as an environment variable on your local machine:

export PRIVATE_KEY='-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA04up8hoqzS1+APIB0RhjXyObwHQnOzhAk5Bd7mhkSbPkyhP1
...
iWlX9HNavcydATJc1f0DpzF0u4zY8PY24RVoW8vk+bJANPp1o2IAkeajCaF3w9nf
q/SyqAWVmvwYuIhDiHDaV2A==
-----END RSA PRIVATE KEY-----'







-----------------------------


create dir
ssh -o StrictHostKeyChecking=no root@<YOUR_INSTANCE_IP> mkdir /app


Check the status:

curl \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$DIGITAL_OCEAN_ACCESS_TOKEN'' \
    "https://api.digitalocean.com/v2/droplets?name=jena-ubuntu-s-1vcpu-2gb-fra1-01"
