if [ -f ~/.bashrc ] ; then
source ~/.bashrc
fi
export PS1='\[\e[31m\]muga \[\e[34m\]\t \W \[\e[36m\]\$ \[\e[37m\]'
##
# Your previous /Users/yoshikawamuga/.bash_profile file was backed up as /Users/yoshikawamuga/.bash_profile.macports-saved_2014-10-16_at_16:04:23
##

# MacPorts Installer addition on 2014-10-16_at_16:04:23: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/yoshikawamuga/.bash_profile file was backed up as /Users/yoshikawamuga/.bash_profile.macports-saved_2014-10-16_at_16:08:00
##

# MacPorts Installer addition on 2014-10-16_at_16:08:00: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

function mountAndroid { hdiutil attach ~/android.dmg -mountpoint /Volumes/android; }

ulimit -S -n 1024

PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'
##
# Your previous /Users/yoshikawamuga/.bash_profile file was backed up as /Users/yoshikawamuga/.bash_profile.macports-saved_2015-01-19_at_19:25:32
##

# MacPorts Installer addition on 2015-01-19_at_19:25:32: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

