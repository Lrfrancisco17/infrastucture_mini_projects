A simple Bash script that detects zombie processes on a Linux system and prints detailed information about each one, including the parent process responsible for creating it.  

Zombie processes don’t consume CPU, but they do indicate that a parent process isn’t cleaning up properly. This script helps you quickly identify them and trace the root cause.


Installation
Make the script executable:  
  #chmod +x check_zombies.sh

(Optional) Move it into your PATH:  
  #sudo mv check_zombies.sh /usr/local/bin/check_zombies

Now you can run it from anywhere:  
  #check_zombies

Run the script:  
  #./check_zombies.sh  



Example output:
Checking for zombie processes...

Zombie processes detected:
--------------------------------------------
Zombie Process:
  1234  5678  Z  some-broken-app

Parent Process:
  5678  S  /usr/bin/python3 server.py
--------------------------------------------



If no zombies are found:
  No zombie processes found.
