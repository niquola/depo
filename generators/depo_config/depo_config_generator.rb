class DepoConfigGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory  File.join('config')
      m.template "depo.rb", File.join('config','depo.rb')
    end
  end
end
