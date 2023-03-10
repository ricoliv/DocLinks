# DOCLinks
DOCLinks reads files and links with extension $extensions from $folderPath and presents in a context menu in notifocation tray
When leftclicking the icon in notification tray, the list of files in $folderPath are shown as menu items and can be executed 
by rightclick

This is a powershell script.

It can be tested with powershell ISE.

It runs in windows notification bar and shows an document-link icon.
 
Can be executed during user logon and activated in gpedit.msc  user - windows - scripts.
In order to show the icon when its task is running, displaying it must be activated once in taskbar context menu.
Icon DocLinks.ico shall be in same directory as the script
Free Icons from https://icon-icons.com/

Attention: power shell scrips must be allowed - this is usually not default and must be activated once.
One can do this by executing as administrator: set-executionpolicy remotesigned