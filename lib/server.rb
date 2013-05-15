require 'rubygems'
require 'reel'
require 'json'
require 'bundler'
require 'active_record'
Bundler.setup

database_configuration = YAML.load(File.read(File.expand_path('../../config/database.yml', __FILE__)))
ActiveRecord::Base.establish_connection(database_configuration['development'])

require_relative 'web_socket_server.rb'

WebSocketServer.supervise_as :websockets_server
sleep
