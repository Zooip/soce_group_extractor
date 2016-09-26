$:.unshift File.dirname(__FILE__)

require 'extra_config'

CUSTOM_CONFIG=ExtraConfig.new(File.expand_path("config.yml",File.dirname(__FILE__)),"SGE")

class SoceGroupExtractor




end