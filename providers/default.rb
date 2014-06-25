#
# Cookbook Name:: modules
# Provider:: modules
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
# Author:: Vasiliy Tolstov <v.tolstov@selfip.ru>
#
# Copyright 2012, Societe Publica.
# Copyright 2014, Vasiliy Tolstov.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


def path_boot
  case node['platform']
  when "exherbo", "ubuntu", "arch"
    return "/etc/modules-load.d/#{new_resource.name}.conf"
  when "debian", "ubuntu"
    return "/etc/modules"
  end
end

def path_opts
  return "/etc/modprobe.d/#{new_resource.name}.conf"
end

def serializeOptions
  output = " "
  unless new_resource.options.nil?
    new_resource.options.each do |option, value|
      output << " #{option}=#{value}"
    end
  end
  return output
end

action :load do
  execute "load module" do
    command "modprobe #{new_resource.module}#{serializeOptions}"
    not_if { ::File.exist?("/sys/module/#{new_resource.module}") }
  end
  if new_resource.autoload
    b = file path_boot do
      content new_resource.module
      owner "root"
      group "root"
      mode "0644"
    end
    new_resource.updated_by_last_action(true) if ( b.updated_by_last_action? )
  end
  if new_resource.save
    unless new_resource.options.nil?
      s = file path_opts do
        content "options #{new_resource.module}#{serializeOptions}\n"
        owner "root"
        group "root"
        mode "0644"
      end
      new_resource.updated_by_last_action(true) if ( s.updated_by_last_action? )
    end
  end
end

action :unload do
  u = execute "unload module" do
    command "modprobe -r #{new_resource.module}"
  end
  new_resource.updated_by_last_action(true) if ( u.updated_by_last_action? )
end

action :blacklist do
  case node['platform']
  when "exherbo", "ubuntu", "arch"
    b = file path_boot do
      action :delete
    end
    new_resource.updated_by_last_action(true) if ( b.updated_by_last_action? )
  when "debian", "ubuntu"
    b = execute "blacklist module" do
      command "sed -i '/#{new_resource.module}/d' #{path_boot}"
    end
    new_resource.updated_by_last_action(true) if ( b.updated_by_last_action? )
  end
  s = file path_opts do
    content "install #{new_resource.module} /bin/false\n"
    owner "root"
    group "root"
    mode "0644"
  end
  new_resource.updated_by_last_action(true) if ( s.updated_by_last_action? )
  modules new_resource.module do
    action :unload
  end
end
