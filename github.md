# Github ssh key

- add config for github/user to .ssh/config:
```
Host github.com-acceleanu
        HostName github.com
        User git
        IdentityFile ~/.ssh/github-acceleanu
```

- as a one-off add private key to the ssh-agent:
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github-acceleanu
ssh-add -l
```

- clone the repo 
```
git clone git@github.com:acceleanu/www
```

- as a more permanent solution, create a script in ~/bin/start-ssh-agent.sh:
```
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add "$HOME/.ssh/github-acceleanu";
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
```

and then add this line in .bashrc:

```
. bin/start-ssh-agent.sh
```

- test the key:
```
ssh -T git@github.com
```
