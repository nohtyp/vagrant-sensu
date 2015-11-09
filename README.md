#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with myfirewall](#setup)
    * [Provision sensu using vagrant](#Provision sensu using vagrant)
    * [Configure system without proper dns](#Configure system without proper dns)
    * [Configure system with proper dns](#Configure system with proper dns (using a resolv.conf puppet module))
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview
This is a sensu module that will install sensu on a vagrant box.  Currently the module
installs and configures the following:

-`Redis`
-`RabbitMQ`
-`Sensu Server`
-`Yum repos`


The module currently only supports RedHat 7 family, but I am working to allow this 
module to work with other OSes.

## Setup

### Provision sensu using vagrant 
Clone the repository:

git clone https://github.com/nohtyp/vagrant-sensu.git

<pre>
Note: I am not using resolv.conf so you need to add it or
or provision the system with `--no-provision`.
</pre>

### Configure system without proper dns

#### Build system without provisioning
<pre>vagrant up test02 --no-provision</pre>

#### Log into system to configure dns
<pre>vagrant ssh test02</pre>

#### Configure dns on system
<pre>echo 'nameserver (your name server..ex 192.168.1.1)' > /etc/resolv.conf</pre>

#### Exit system and provision
<pre>exit
vagrant provision test02
</pre> 


### Configure system with proper dns (using a resolv.conf puppet module)

#### Build system
<pre>vagrant up test02</pre>

#### Test server is running
<pre>http://192.168.2.201:3000</pre>

### Limitations

Currently this module is compatible with RedHat 7 family.  I am working on 
other OSes and will update this accordingly.  The module currently
supports the following options:

Currently this module is working for RedHat 7 family.

### Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

### Release Notes/Contributors/Etc
This is the first release of this module.  I will be updating
the notes when applicable.
