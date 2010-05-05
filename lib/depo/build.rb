require 'erb'
require 'fileutils'

module Depo
  class Build
    class << self
      def generate_profile(opts={})
        @rails_root = opts[:rails_root] if opts.key?(:rails_root)
        profile_content = profile_template.result(binding)
        open(profile_path,'w') do |f|
          f<< profile_content
        end
      end

      def profile_path
        raise "I need RAILS ROOT to generate profile" unless Object.const_defined? :RAILS_ROOT
        file_path = File.join(RAILS_ROOT,Depo.config.profile_path)
        file_dir = File.dirname(file_path)
        unless File.exists?(file_dir)
          FileUtils.mkdir_p(file_dir)
        end
        file_path
      end

      def profile_template
        return @template if @template
        tpl_string = File.read("#{File.dirname(__FILE__)}/templates/profile.js")
        @template = ERB.new(tpl_string)
      end

      def layers
        Depo.config.build_profile.pages.map do |page|
          file="../#{page.gsub('.','/')}.js"
          <<-JS
          {
            name:"#{file}",
            dependencies: ["#{page}"]
          }
          JS
        end.join(',')
      end

      def prefixes
        result = %w{dijit dojox}.map{|lib| %Q<["#{lib}","../#{lib}"]>}
        Depo.config.build_profile.libs.each do |lib|
          result<< %Q<["#{lib}","#{@rails_root}/#{Depo.config.src_path}/#{lib}"]>
        end
        "#{result.join(',')}"
      end

    end
  end
end
