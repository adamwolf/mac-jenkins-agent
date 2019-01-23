Mac Jenkins Agent
=================

I have a few Mac Jenkins agents that are not accessible via SSH.  For a while, I would just SSH into them after VPNing in, and then start a screen session with a little snippet that downloads the agent.jar and gets everything going.

This is better than that.

Note: This does not do any extra verification that the agent.jar is downloading from the proper place.  Use HTTPS, so an attacker would have to break at least one more thing.  Also, please note, if the Jenkins machine is compromised, it can easily compromise your agents.

Usage
=====

Setup the agent in Jenkins.  We'll call the Jenkins machine `builder` and the agent `agnew` for this example.

Create a new user. We'll call the user `jenkinsbuilder`.  Copy this repository to their home directory, and edit the script and plist appropriately.

As the user, run the start-jenkins-agent.sh script.  Go to your Jenkins machine, and verify that it says that `agnew` is nline.

Now, setup the LaunchDaemon. Copy or symlink the plist to /Library/LaunchDaemons/.  Load it with the following command: `sudo launchctl load -w /Library/LaunchDaemons/org.adamwolf.mac-jenkins-agent.plist`.

Uninstallation
==============

`sudo launchctl unload -w /Library/LaunchDaemons/org.adamwolf.mac-jenkins-agent.plist`

Delete the user, delete the home directory. Delete `/tmp/mac-jenkins-agent*` and `/Library/LaunchDaemons/org.adamwolf.mac-jenkins-agent.plist`

Resources
=========

For more information on the configuration options in the plist, see http://www.launchd.info/.
