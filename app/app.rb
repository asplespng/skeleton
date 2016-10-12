require 'bundler'
require 'ostruct'
Bundler.require

set :sprockets, Sprockets::Environment.new

%w[stylesheets javascripts fonts].each {|path| settings.sprockets.append_path "assets/#{path}"}
RailsAssets.load_paths.each {|path| settings.sprockets.append_path path}
settings.sprockets.css_compressor = :scss
settings.sprockets.js_compressor  = :uglify

settings.sprockets.context_class.class_eval do
  def asset_path(path, options = {})
    "/assets/#{path}"
  end
end

get "/assets/*" do
  env["PATH_INFO"].sub!("/assets", "")
  settings.sprockets.call(env)
end

get '/' do
  @greeting = "Hi there"
  @user = OpenStruct.new
  @user.errors = {name: ["An error has occured"]}
  @user.name = "John Doe"
  haml :index
end
