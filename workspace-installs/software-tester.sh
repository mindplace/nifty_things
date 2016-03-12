#!/bin/bash

#   Software checker:
# checks for any software it's passed and returns its versions or 
# lets you know that it's not been found 
#
# -----------------------------------------
#        HOW TO RUN THIS SCRIPT: 
# 1. Use cd to navigate to the folder where this 
#    script is stored.
# 2. Enter the following:  ./software_tester
#
# ------------------------------------------

if [ -s $@ ]
then
  echo
  echo "Let's test to make sure you have all the software you need!"
  echo "You can pass this file as many items of software as you want"
  echo "to check, like so:"
  echo
  echo " ./software_tester ruby git sqlite3"
  echo
  echo "You should first try it out with the following items, because"
  echo "these are the ones you'll definitely need:"
  echo
  echo "ruby rspec git node sqlite3"
  echo
  echo "Some other things you'll eventually need: "
  echo "Atom (atom)/Sublime (subl), Homebrew (brew), PostGres (postgres),"
  echo "Ruby Version Manager (rvm), Gems (gem), Bundler (bundle)."
  echo
  echo "if the program can't find the item you asked for, it'll let you,"
  echo "know like so:"
  echo
  echo "  ./software_tester: line 30: [your item]: command not found"
  echo
  echo "Ok, try it out!"
  echo
fi

for element in "$@"
do
  echo
  echo "$element"
  "$element" --version
done

echo