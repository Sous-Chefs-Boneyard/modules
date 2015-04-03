actions :load, :unload, :blacklist, :autoload

default_action :load

attribute :module, :kind_of => String, :name_attribute => true
attribute :options, :kind_of => Hash, :default => nil
attribute :autoload, :kind_of => [TrueClass, FalseClass], :default => true
attribute :save, :kind_of => [TrueClass, FalseClass], :default => true

# Covers 0.10.8 and earlier
def initialize(*args)
  super
  @action = :load
end
