class DpageGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions "#{class_name}Controller", "#{class_name}ControllerTest", "#{class_name}Helper", "#{class_name}HelperTest"

      action = actions[0]
      page=Depo::DijitConventions.new("#{Depo.config.default_page_lib}.#{action}")
      
      # Controller, helper, views, and test directories.
      m.directory File.join('app/controllers', class_path)
      m.directory File.join('app/helpers', class_path)
      m.directory File.join('app/views', class_path, file_name)
      m.directory File.join('test/unit/helpers', class_path)
      m.directory page.package_path

      # Controller class, functional test, and helper class.
      m.template 'controller.rb',
        File.join('app/controllers',
                  class_path,
                            "#{file_name}_controller.rb")

      m.template 'helper.rb',
        File.join('app/helpers',
                  class_path,
                            "#{file_name}_helper.rb")

      m.template 'helper_test.rb',
        File.join('test/unit/helpers',
                  class_path,
                            "#{file_name}_helper_test.rb")

      path = File.join('app/views', class_path, file_name, "#{action}.haml")
      m.template 'view.haml', path, :assigns => { :action => action, :path => path }

      m.template 'dpage.js', page.class_path, :assigns => { :page_name=> page.dijit_full_name }
    end
  end
end
