modules-cookbook
================

= DESCRIPTION:
Chef cookbook to manage linux modules with /etc/modules and modprobe (linux 2.6 +)

= REQUIREMENTS:

Linux 2.6+
Ubuntu >9.10 (for the moment. use upstart and not init)

= ATTRIBUTES:
node[:modules] = A namespace for modules settings.

= USAGE:
There are two ways of setting sysctl values:
1. Set chef attributes in the _sysctl_ namespace, E.G.:
 <tt>default[:modules][:loop][:options] = nil</tt>
2. With Ressource/Provider

Resource/Provider
=================

This cookbook includes LWRPs for managing:
* modules
* modules_multi

modules
--------

# Actions

- :save: save and load a module (default)
- :load: load a module
- :remove: remove a (previous save) module.

# Attribute Parameters

- variable: variable to manage. "net.ipv4.ip_forward", "vm.swappiness" ...
- value: value to affect to variable. "1", "0" ...
- path: path to a specific file

# Examples
    # set "vm.swappiness" to "60". will create /etc/sysctl.d/40-vm.wappiness.conf
    sysctl "vm.swappiness" do
      value "40"
    end
   
   # the same. will create /etc/sysctl.d/40-vm_swappiness_to_60.conf
   sysctl "vm swappiness to 60" do
     variable "vm.swappiness"
     value "60"
   end

   #remove /etc/sysctl.d/40-ip_config.conf
   sysctl "ip config" do
     action :remove
   end

   #set swappiness but don't save it
   sysctl "vm.swappiness" do
     value "40"
     action :set
   end

modules_multi
------------

#Actions

- :save: save and set a sysctl value (default)
- :set: set a sysctl value
- :remove: remove a (previous set) sysctl.

# Attribute Parameters

- instructions: hash with instruction {variable => value, variable2 => value2}. override use of "variable" and "value".
- path: path to a specific file

# Examples
   # set multi variables. will create /etc/sysctl.d/69-ip_config.conf
   sysctl_multi "ip config" do
     instructions { "net.ipv4.ip_forward" => "1", "net.ipv6.conf.all.forwarding" => "1", "net.ipv4.tcp_syncookies" => "1" }
   end