run theese commands and configure your secrets!
cp useful/template.secrets.py secrets.py
cp useful/template.variables.js node/variables.js
cp useful/template.live_variables.js node/live_variables.js

it's important that variables.js points to http://adventureland:8083 because the main appserver service is called adventureland in docker-compose.yml

after creating your account it will not be verified
after creating you first character, if the screen is black, there is something wrong with the socket connnection and you have to log out and in again.
