def initialize(*args)
  super
  @action = :save
end

actions :save, :remove

attribute :name, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String, :default => nil
attribute :modules, :kind_of => Array, :default => nil, :required => true