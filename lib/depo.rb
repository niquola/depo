$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'kung_figure'
module Depo
  VERSION = '0.0.1'
  autoload :Config, 'depo/config'
  autoload :Build, 'depo/build'
  autoload :DijitConventions, 'depo/dijit_conventions'
  include KungFigure
end
