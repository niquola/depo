$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
module Depo
  VERSION = '0.0.1'
  autoload :Config, 'depo/config'
  autoload :PathUtils, 'depo/path_utils'
  class << self
    attr :config
    def configure(&block)
      @config = Config.new
      @config.instance_eval &block
    end
  end
end
