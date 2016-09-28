require 'sinatra'
require 'sprockets'
require 'sass'
require 'rails-assets-bootstrap'
require 'rails-assets-jquery'

set :sprockets, Sprockets::Environment.new

settings.sprockets.append_path "assets/stylesheets"
settings.sprockets.append_path "assets/javascripts"
settings.sprockets.css_compressor = :scss
# settings.sprockets.js_compressor  = :uglify

settings.sprockets.context_class.class_eval do
  def asset_path(path, options = {})
    "/assets/#{path}"
  end
end

RailsAssets.load_paths.each do |path|
  settings.sprockets.append_path path
end

get "/assets/*" do
  env["PATH_INFO"].sub!("/assets", "")
  settings.sprockets.call(env)
end

get '/' do
  haml :index
end
