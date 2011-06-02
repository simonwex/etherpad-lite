#!/bin/bash                 

#Stop the script if its started as root
if [[ $EUID -eq 0 ]]; then
   echo "You shouldn't start Etherpad-Lite as root!" 1>&2
   echo "Use authbind if you want to use a port lower than 1024 -> http://en.wikipedia.org/wiki/Authbind" 1>&2
   exit 1
fi

#Is node installed?
type -P node &>/dev/null || { 
  echo "You need to install node to run Etherpad-Lite!" >&2
  exit 1 
}

#Is node installed?
type -P npm &>/dev/null || { 
  echo "You need to install npmq to run Etherpad-Lite!" >&2
  exit 1 
}

#Was this script started in the bin folder? if yes move out
if [ -d "../bin" ]; then
  cd "../"
fi

#Does a settings.json exist? if no copy the template
if [ ! -f "settings.json" ]; then
  echo "Copy the settings template to settings.json..."
  cp -v settings.json.template settings.json 
fi

#Remove all minified data to force node creating it new
echo "Clear minfified cache..."
rm var/minified* 2> /dev/null

#Ensure all dependencies are installed
echo "Ensure dependencies are up to date..."
npm link

#Move to the node folder and start
echo "start..."
cd "node"
node server.js
