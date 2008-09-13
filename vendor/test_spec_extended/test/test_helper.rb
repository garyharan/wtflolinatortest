$:.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__)))

require 'rubygems'
begin require 'redgreen'; rescue LoadError; end

require 'test/spec'
require 'meta_tests'