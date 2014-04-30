sudo
====

####Table of Contents

1. [Overview - What is the sudo module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with sudo](#setup)
4. [Usage - The parameters available for configuration](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

Overview
--------
Secure extensible sudo management with puppet.

Module Description
------------------

Manages rules, commands, hosts and runas entries in sudo

Setup
-----

**what sudo affects:**

* /etc/sudoers file

### Beginning with sudo

This will manage a basic setup for sudo.

    include sudo

Defaults for vars to set if you need them.
These are class params so use hiera or and ENC to set them up easily.

    $sudo::params::extra_full_sudo_users = [] 
    # array of extra users with full sudo access except shells and su itself
    $sudo::params::requiretty = false
    # whether you want a tty to exist for sudo ( I leave this unset because my monitoring setup uses sudo for some of it's commands )
    $sudo::params::extra_path = undef
    # extra path to include before the default
    $sudo::params::extra_shells = undef
    # extra shells on the node

Usage
-----

    sudo::rule { "extra_rule":
      ensure => present, 
      who => 'bob', 
      commands => "/usr/sbin/systemctl",
      nopass => false, # 
      comment => "what ever you like",
    }

### sudo::rule

This type manages extra rules for sudo

**Parameters within sudo::rule**

#### `ensure`

Whether the rule should exist or not (present is the default)

#### `who`

The user running the command

#### `commands`

can also be an array of commands for this rule

#### `nopass`

whether you want the user to supply a password or not  (defaults to false)

#### `comment`

Interted above the rule to explain what it does


    sudo::cmnd { "SYSTEMD":
      ensure => present, # whether the rule should exist or not (present is the default)
      what => '/usr/sbin/systemctl', # can also be an array of commands
      cmnd => "BLAH", # name for these commands
      comment => "what ever you like",
    }

### sudo::cmnd

This type manages extra command sets for sudo

**Parameters within sudo::cmnd**

#### `ensure`

Whether the cmnd set should exist or not (present is the default)

#### `what`

Commands in this set, can be a variable or an array.

#### `cmnd`

Name for this command set

#### `comment`

Interted above the cmnd to explain what it does

    sudo::host { "office":
      ensure => present, # whether the rule should exist or not (present is the default)
      where => 'nagios.example.com', # can also be an array of hosts
      comment => "what ever you like",
    }

### sudo::host

This type manages host groups for sudo

**Parameters within sudo::host**

#### `ensure`

Whether the host group should exist or not (present is the default)

#### `where`

Host or array of hosts in this group

#### `comment`

Description of this host group

    sudo::runas { "whoever":
      ensure => present, # whether the rule should exist or not (present is the default)
      who => 'bob', # can also be an array of users
      comment => "what ever you like",
    }

### sudo::runas

This type manages extra runas groups for sudo

**Parameters within sudo::runas**

#### `ensure`

Whether the runas group should exist or not (present is the default)

#### `who`

who this group contains, can be a variable or an array

#### `comment`

Description of this runas group 


Implementation
--------------

uses templates and concat to manage the /etc/sudoers file

Limitations
------------

There may be some. Don't hesitate to let me know if you find any.

Development
-----------

All development, testing and releasing is done by me at this stage.
If you wish to join in let me know.

Release Notes
-------------

**1.0.0**

Initial release
