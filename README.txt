Command Linode control over Linode thru the Linode API.

Here's the expected command line interface

API Key is read from
  - ENV["LINODE_API_KEY"]
  - ~/.linode.yml's api_token key

linode stackscript list
  - Lists all your stackscripts

linode stackscript <stackscript_id> [-o] [-u update_stackscript_script]
  - Shows content with meta data of given stackscript
  - -o Outputs the stackscipt text only, good with redirection to file of your choice
  - -u Updates stackscript by reading from specified file
  - -e name:value pair of attributes to be updated for the given stackscript

linode stackscript download [--dir=<dir>]
  - Downloads all your stackscripts in the format <stackscript_id>.stack.sh in the current directory or a directory of your choosing

linode stackscript upload [-dir=<dir>]
  - Uploads all files in the format <stackscript_id>.stack.sh in the current directory or a directory of your choosing onto linode.

Note: I'm still trying to find the best and cleanest way to implement it. All a spike so far.
If you use it, best to read the code to figure this out and fork and pull.