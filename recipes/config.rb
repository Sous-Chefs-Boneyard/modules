#
# Cookbook Name:: modules
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 20012, Societe Publica.
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

return unless supported?
node['modules']['packages'].each do |p|
  package p
end

directory '/etc/modules-load.d' do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/modules-load.d/header' do
  source 'modules-load_header'
  owner 'root'
  group 'root'
  mode '0644'
end

# include init job
include_recipe "modules::_#{node['modules']['init']}"

