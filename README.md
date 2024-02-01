# toolbox 
### automate bash scripting
- Install by running toolbox-setup.sh
  
- run **$toolbox-create NAME**
  to make a new project from template.

- When inside a project directory, run **$toolbox-mkver**</br>
  to create a new archive of that version.</br>
  **Remember to change the VERSION= variable in the main script.**
  
- Running **$toolbox-setup.sh** will install all scripts in that same directory.
  or install a single script with **$toolbox-setup.sh NAME**

- All script's install.sh file should include any dependencies in the DEPENDENCIES=("") variable,</br>
  these will be installed by the depin.sh script on systems with apt,dnf or zypper.
