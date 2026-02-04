What This Playbook Does  
The playbook performs one of two actions on your target hosts:

Install a package (action=install)
Remove a package (action=remove)

The task that runs depends entirely on the value of the action variable. This makes the playbook flexible without needing to modify the YAML each time.

Both tasks use the package module, so it works across multiple Linux distributions.


How to Run the Playbook
You can run the playbook using ansible-playbook and override variables directly from the command line.

1. Install a Package  
   ansible-playbook pkg_install.yml -e "package=httpd action=install"  
   This will install the httpd package on all hosts in your inventory.

2. Remove a Package  
    ansible-playbook pkg_install.yml -e "package=httpd action=remove"  
    This removes the package instead.



Optional: Use an Inventory File
If your inventory isn’t already defined globally, specify it:

3. Add inventory flag to point to inventory       
   ansible-playbook -i inventory.ini pkg_install.yml -e "package=vim action=install"

Why This Playbook Is Dynamic

Instead of hardcoding package names or actions, you expose them as variables. This allows users to:
Install any package they want  
Remove any package they want  
Reuse the same playbook across multiple environments  
Integrate it into larger automation workflows or CI/CD pipelines  

Published by: Luis Francisco  
Contact: lrfrancisco17@gmail.com  
Social: https://www.linkedin.com/in/luisfrancisco  
Youtube: https://www.youtube.com/@Innovationlu  

