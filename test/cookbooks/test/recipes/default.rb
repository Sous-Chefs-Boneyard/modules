modules 'test' do
  action [:save, :load]
end

modules_multi 'test' do
  modules ['test']
  action :save
end
