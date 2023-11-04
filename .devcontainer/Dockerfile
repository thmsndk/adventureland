FROM node:16

# update base image and get latest packages
RUN apt-get update && apt-get upgrade -y

# TODO: Do we want this in the "root" should it live somewhere else?
# Clone a modified copy of Python2 App Engine Local App Server into the python folder along with an initialized database with map files:
RUN git clone https://github.com/kaansoral/adventureland-appserver appserver

# get the dev version of python2 to install the reqs lower <-- because Atlus said so :P
RUN apt-get install python2-dev -y

# get pip as per installation instructions - not sure what it is used for
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
RUN python2.7 get-pip.py
RUN pip2.7 check

# use python to install pip
RUN python2 get-pip.py

# why are we copying the current location into adventureland?
# make the AL directory, and enter it
# RUN mkdir adventureland && cd adventureland

# copy from the current location to our AL folder
COPY ../ /adventureland 
# ^^ WORKS

# pretty sure we are running from within .devcontainer, so that makes no sense.

# can't get symbolic links to work :thinking:
# Create a symbolic link 'adventureland' pointing to the workspace
# RUN ln -s /adventureland .
# RUN ln -s . /adventureland
# RUN ln -s ../ /adventureland

# https://stackoverflow.com/a/65443098/28145
# nodejs >= 15 npm install is executed in the root directory of the container 

RUN ls
CMD pwd

# run npm install on /adventureland/scripts
WORKDIR ./adventureland/scripts
RUN npm install

# run npm install on /adventureland/node
WORKDIR ../node
RUN npm install 

# i don't think we need all of these. need to do more research
EXPOSE 8082
EXPOSE 8083
EXPOSE 43291
EXPOSE 8000

# add execution perms to the entrypoints
# RUN chmod +x ../adventureland/appserver-entrypoint.sh
# RUN chmod +x ../adventureland/node-server-entrypoint.sh

# /adventureland
WORKDIR ../
RUN chmod +x appserver-entrypoint.sh
RUN chmod +x node-server-entrypoint.sh

# why are we exposing some ports?

# what are theese entrypoint scripts that we chmod? and what is the default entry point?

# docker-entrypoint.sh is responsible for starting the appserver

#node-entrypoint.sh is for starting the server can we use nodemon / pm2 to restart it on changes?

# https://stackoverflow.com/a/67813516/28145

# doing docker build -t al . && docker-compose up builds the image and starts the servers

# This file sets up a message that will be displayed when we open the terminal in VSCode.
COPY .devcontainer/welcome.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt