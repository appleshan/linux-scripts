#!/bin/bash

# arch linux
pacman -Q | awk '{print $1}' > package_list.txt

# ubuntu
