# toolbox 
### Automate bash scripting, versioning and install
- Install by running **`./toolbox-setup.sh`** as root.
  
- run **`$toolbox-mknew <NAME>`**
  to make a new project from template in the current directory.

- When inside a project directory, run **`$toolbox-mkver <OPTION>`**</br>
  to create a new archive, package or "github version" of current.</br>
  **Remember to change the VERSION= variable in the main script.**
  
- Create a new bug report by navigating to the project directory and run<br>
  **`$toolbox-mkbug`**.

- All scripts' install.sh file should include any dependencies in the DEPENDENCIES=("") variable,</br>
  these will be installed by the depin.sh script on systems with apt,dnf or zypper.


## Happy scripting! :)
