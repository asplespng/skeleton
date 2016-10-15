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
  @user = OpenStruct.new
  @user.name = "John Doe"
  haml :index
end

post '/users' do
  @user = OpenStruct.new
  @user.name = params[:name]
  @user.email = params[:email]
  @user.password = params[:password]
  @user.birthday = params[:birthday]
  @user.errors = {name: ["can't be blank"]} unless @user.name.present?
  haml :index
end
