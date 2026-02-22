#!/bin/bash
# Author: 4ndr0666
# ================= // SSH_SETUP.SH //
## Description: This small script should be called with 
#  curl to setup ssh authorized keys on the remote host like
#  this: curl -sSL https://www.github.com/nas/docs/ssh/ssh_setup.sh | bash
# --------------------------------------------------------------

mkdir -p ~/.ssh                                                           
chmod 700 ~/.ssh                                                          
curl -s https://github.com/4ndr0666.keys >> ~/.ssh/authorized_keys        
chmod 600 ~/.ssh/authorized_keys  
