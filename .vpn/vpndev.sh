#!/bin/zsh

SERVER=https://sky.carasent.no/dev
USER='Constantin'
PASS='Testare1!'

expect -c "
spawn openconnect --juniper ${SERVER} --user=${USER}
expect \"Password:\"
send \"${PASS}\n\"
interact
"
