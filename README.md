#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with myfirewall](#setup)
    * [Provision sensu using vagrant](#Provision sensu using vagrant)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview
This is a sensu module that will install sensu on a vagrant box.  Currently the module
installs and configures the following:

- `Redis`
- `RabbitMQ`
- `Sensu Server`
- `Yum repos`


The module currently only supports RedHat 7 family, but I am working to allow this 
module to work with other OSes.

## Setup

### Provision sensu using vagrant 
Clone the repository:

git clone https://github.com/nohtyp/vagrant-sensu.git

#### Provision systems
vagrant up

#### Test server is running
<pre>http://192.168.2.200:3000</pre>

### Limitations

Currently this module is compatible with RedHat 7 family.  I am working on 
other OSes and will update this accordingly.  The module currently
supports the following options:

Currently this module is working for RedHat 7 family.

### Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

### Release Notes/Contributors/Etc
I will be adding configurations for sensu client/server configurations (later).
Now you can copy the files to the client or server and do what you want.
