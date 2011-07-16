Command Linode control over Linode thru the Linode API.

Here's the expected command line interface

API Key is read from
  - ENV["LINODE_API_KEY"]
  - ~/.linode

linode stackscript list
  - Lists all your stackscripts

linode stackscript <stackscript_id> [-o] [-u update_stackscript_script]
  - Shows content with meta data of given stackscript
  - -o Outputs the stackscipt text only, good with redirection to file of your choice
  - -u Updates stackscript by reading from specified file
  - -e name:value pair of attributes to be updated for the given stackscript

linode stackscript download [-d <dir>]
  - Downloads all your stackscripts in the format <stackscript_id>.stack.sh in the current directory or a directory of your choosing

linode stackscript upload [-d <dir>]
  - Uploads all files in the format <stackscript_id>.stack.sh in the current directory or a directory of your choosing onto linode.

