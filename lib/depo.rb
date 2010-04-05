$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'kung_figure'
require 'active_support'

module Depo
  VERSION = '0.0.1'
  autoload :Config, 'depo/config'
  autoload :Build, 'depo/build'
  autoload :DijitConventions, 'depo/dijit_conventions'
  autoload :ViewHelpers, 'depo/view_helpers'
  include KungFigure
  class << self
    def dojofy
      Dir.chdir(RAILS_ROOT)
      version = Depo.config.dojo_version
      system "dojofy #{Depo.config.src_path} #{version}"
    end
    def enable
      return if ActionView::Base.instance_methods.include? 'dojo'
      if defined?(ActionController::Base) 
        ActionView::Base.send :include, ViewHelpers
      end
      dojofy if Depo.config.enable_dojofy 
    end
  end
end

if defined?(Rails) and defined?(ActionView)
  Depo.enable
end
