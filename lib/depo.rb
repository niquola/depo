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
    def enable
      return if ActionView::Base.instance_methods.include? 'dojo'
      if defined?(ActionController::Base) 
        ActionView::Base.send :include, ViewHelpers
      end
    end
  end
end

if defined?(Rails) and defined?(ActionView)
  Depo.enable
end
