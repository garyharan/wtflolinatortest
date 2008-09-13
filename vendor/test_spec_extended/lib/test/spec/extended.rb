begin
  require 'test/spec'
rescue LoadError
  begin
    gem 'test-spec'
    require 'test/spec'
  rescue LoadError
    puts "Install test/spec or you're out of luck."
  end
end

module Test::Spec::Extended
  VERSION = "0.1"
end


glob = File.join(File.dirname(__FILE__), 'extended/*.rb')
Dir[glob].each do |file|
  require file
end
# Dir["extended/*.rb"].each do |file|
#   debugger
#   puts "o hai" + file.to_s
#   require file[/should_[^.]*/]
# end