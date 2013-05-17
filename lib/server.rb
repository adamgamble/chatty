require_relative '../config/environment.rb'
require_relative 'web_socket_server.rb'
require_relative 'chat_logger.rb'

WebSocketServer.supervise_as :websockets_server
sleep
