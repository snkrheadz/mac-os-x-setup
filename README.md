# Mac OS X Setup

This is a provisioning for my MacBook which is designed from my MacBook environment.

## Syntax check

```sh
ansible-playbook -i etc/ansible/hosts site.yml --syntax-check
```

## List tasks

```sh
ansible-playbook -i etc/ansible/hosts site.yml --list-tasks
```

## Check

Run command below and type your sudo pass, because task `Change login shell to fish` use option `become_method: sudo` .

```sh
ansible-playbook -i etc/ansible/hosts site.yml --check --ask-sudo-pass
```

## Workflow

** Shell Script **
- Install Homebrew
- Install Homebrew packages
- Install NeoBundle
- Install Oh My Fish
- Run ansible-playbook
- Install atom packages

** Ansible Playbook task lists **

```
playbook: site.yml

  play #1 (localhost): Set up my MacBook	TAGS: []
    tasks:
      homebrew-cask : Tap Homebrew Cask	TAGS: [homebrew-cask]
      homebrew-cask : Install/Upgrade Homebrew Cask	TAGS: [homebrew-cask]
      homebrew-cask : Tap external Homebrew Cask repositories	TAGS: [homebrew-cask]
      homebrew-cask : Install/Upgrade Homebrew Cask packages	TAGS: [homebrew-cask]
      env : Make .nvm directory	TAGS: [env]
      env : Make alias of nvm	TAGS: [env]
      env : Copy envs	TAGS: [env]
      env : Clone git repositories	TAGS: [env]
      env : Change login shell to /usr/local/bin/fish	TAGS: [env]
      mac : Check if iterm2 config is differ	TAGS: [mac]
      mac : Install iterm2 imgls	TAGS: [mac]
      mac : Install iterm2 imgcat	TAGS: [mac]
      mac : Install ricty fonts	TAGS: [mac]
      mac : Setup OS X defaults	TAGS: [mac]
      mac : Setup OS X defaults which use array values and restart Finder, Dock and Menubar	TAGS: [mac]
      mac : Install ruby versions by rbenv	TAGS: [mac]
      mac : Setup global ruby version t0 2.3.1 by rbenv	TAGS: [mac]
      mac : Install gem files ( bundler and rails )	TAGS: [mac]
```

## Restart shell as bash

Run command below to check your bash binary path

```sh
cat /etc/shells
```

Run command below to change your shell to `bash` if your shell is not `bash` .

```sh
# Change default shell to bash
chsh -s /bin/bash

# Force restart with following command or just re-open terminal window
exec /bin/bash -l
```

## Install

Run following shell script to install my OSX setting on MacBook.

```sh
. install.sh
```

Open new terminal window after finish installation.  
And or you should also restart your MacBook.


### Ansible Playbook [Directory Layout](http://docs.ansible.com/ansible/playbooks_best_practices.html#directory-layout)

The top level of the directory would contain files and directories like so:

```
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
   group1                 # here we assign variables to particular groups
   group2                 # ""
host_vars/
   hostname1              # if systems need specific variables, put them here
   hostname2              # ""

library/                  # if any custom modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
```

## Link

- [Ansible Documentation](http://docs.ansible.com/ansible/index.html)
- [ansible playbook コマンド](https://github.com/yteraoka/ansible-tutorial/wiki/ansible-playbook%20%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)
