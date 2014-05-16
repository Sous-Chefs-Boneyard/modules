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
  output = ""
  if new_resource.options
    new_resource.options.each do |option, value|
      output << " #{option}=#{value}"
    end
  end
  return output
end

action :load do
  execute "load module" do
    command "modprobe #{new_resource.module} #{serializeOptions}"
  end
  if new_resource.autoload
    b = file path_boot do
      content new_resource.module
      owner "root"
      group "root"
      mode "0644"
    end
  end
  if new_resource.save
    s = file path_opts do
      content "options #{new_resource.module} #{serializeOptions}\n"
      owner "root"
      group "root"
      mode "0644"
    end
  end
  new_resource.updated_by_last_action(true) if ( b.updated_by_last_action? or s.updated_by_last_action? )
end

action :unload do
  execute "unload module" do
    command "modprobe -r #{new_resource.module}"
  end
end

action :blacklist do
  case node['platform']
  when "exherbo", "ubuntu", "arch"
    b = file path_boot do
      action :delete
    end
  when "debian", "ubuntu"
    b = execute "blacklist module" do
      command "sed -i '/#{new_resource.module}/d' #{path_boot}"
    end
  end
  s = file path_opts do
    content "install #{new_resource.module} /bin/false\n"
    owner "root"
    group "root"
    mode "0644"
  end
  modules new_resource.module do
    action :unload
  end
  new_resource.updated_by_last_action(true) if ( b.updated_by_last_action? or s.updated_by_last_action? )
end
