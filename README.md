# toolbox 
### Automate bash scripting, versioning and install
- Install by running **`./toolbox-setup.sh`** as root.
  
- run **`$toolbox-create NAME`**
  to make a new project from template in the current directory.

- When inside a project directory, run **`$toolbox-mkver <OPTION>`**</br>
  to create a new archive, package or "github version" of that version.</br>
  **Remember to change the VERSION= variable in the main script.**
  
- Running **`./toolbox-setup.sh`** will install all scripts in that same directory.</br>
  or install a single script with **`./toolbox-setup.sh NAME`**</br>
  You can also run install.sh from inside that specific scripts' directory.

- All scripts' install.sh file should include any dependencies in the DEPENDENCIES=("") variable,</br>
  these will be installed by the depin.sh script on systems with apt,dnf or zypper.


## Happy scripting! :)
