name             "modules"
maintainer       "Guilhem Lettron"
maintainer_email "guilhem.lettron@youscribe.com"
license          "Apache v2.0"
description      "Manage modules on linux"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

%w{ubuntu debian fedora gentoo arch exherbo}.each do |os|
  supports os
end
