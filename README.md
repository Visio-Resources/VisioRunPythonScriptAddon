# Run a Python script from within Visio

Python scripts can be run from Visio by adding a hyperlink to the script to any shape, but this does produce a security warning. The Event cells cannot invoke Python scripts though. So, I have created a Visio add-on that can invoke a Python script from any of the shape Event cells, or even an Action cell, though this may be less useful.
The installer below contains an example diagram that should work with any version of Visio from Visio 2003 onwards, and a Python script that just displays the full names of all the open documents (including stencils).
The cell linking to the Python script to be run should contain a formula viz:
RUNADDONWARGS("runPythonScriptFromVisio",SUBSTITUTE(DIRECTORY()," ","%20")&"printdocs.py")
1. runPythonScriptFromVisio is the name of the addon that Visio calls to do all this
2. SUBSTITUTE(DIRECTORY()," ","%20") gets the path of the folder where the Visio document was loaded from (and where, hopefully, the Python script is located) and replaces any spaces in the path with %20, the code value for a space. The addon restores these spaces before activating the Python script.
If you wish to run a script from some other location then you need to manually replace spaces in the path of filename with the %20 text e.g. c:\users\bert\My Documents\My Shapes\ becomes c:\users\bert\My%20Documents\My%20Shapes\.
3. printdocs.py - the name of the script to be invoked. P.S. only Python scripts are allowed, the addon does check this.
The addon itself was written in Lazarus/FreePascal.

Here is the example text output:

![image](https://github.com/user-attachments/assets/a9c05840-ec8e-4df5-8735-5fd1dcbc62bd)
