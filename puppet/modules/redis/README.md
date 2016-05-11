# redis

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)

## Overview
This puppet module is to install and configure redis. This module uses a hash to
build the conf files.

## Module Description
This is a simple puppet module that will configure redis and allow configuraitons
using hiera or modifying the defaults using a hash.

Currently, this module will work for RedHat 7 and I will be working on updating with
more in the upcoming releases.

## Usage

This puppet module uses a hash with the defaults from the current version of redis for
RedHat 7 family OS.  This module is pretty easy to use to manage the redis conf file
because it uses the hash to build the file (without the comments). There is no need to
update the module if you want to add a new entry to the redis.conf file, all you would 
need to do is add it to the hash and the next time you apply the module it should exist
in the correct file.

### There are 2 ways of currently adding to the hash:
1.   Add/Delete/Modify value in params.pp file (This will make any system that applies this
     module use those settings.  Usage: Use this option only if you want to apply the settings
     to all machines).
2.   In the params.pp file set use_hiera and use_sentinel_hiera parameters to `true`.  This will
     allow a more flexible configuration for you redis cluster.  To create a hash using the hiera
     data:

### Hiera config file for Redis system

#### Adding value to hash
<pre>
redis::redis_config: 
  bind: '127.0.0.1'
  daemonize: 'no'

redis::redis_sentinel_conf:
  port: '6379'
  dir: '/tmp'
  'sentinel monitor mymaster': "%{::ipaddress_lo} 6379 2"
</pre> 


#### Removing value from hash (if you don't provide the value then it will not exist in the file)
<pre>
redis::redis_config:
  bind: '127.0.0.1'

redis::redis_sentinel_conf:
  port: '6379'
  'sentinel monitor mymaster': "%{::ipaddress_lo} 6379 2"
</pre> 

## Release Notes/Contributors/Etc **Optional**

There is an issue with using hashes in ruby with the manifests and ERB templates.  To fix issue
just make the key a unique value so that the erb template can parse hash correctly.

Ex: save option for redis:

  'save 900'                    => '1',
  'save 300'                    => '10',
  'save 60'                     => '10000',

