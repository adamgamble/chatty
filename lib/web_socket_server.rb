require_relative 'chat_client'

class WebSocketServer < Reel::Server
  include Celluloid::Logger
  include Celluloid::Notifications

  def initialize(host = "0.0.0.0", port = 1234)
    info "Websockets server starting on #{host}:#{port}"
    super(host, port, &method(:on_connection))
  end

  def on_connection(connection)
    while request = connection.request
      case request
      when Reel::Request
        route_request connection, request
      when Reel::WebSocket
        info "Received a WebSocket connection"
        route_websocket request
      end
    end
  end

  def route_request(connection, request)
    info "404 Not Found: #{request.path}"
    connection.respond :not_found, "Not found"
  end

  def route_websocket(socket)
    info 'handling route_websocket'
    if socket.url == "/"
      ChatClient.new(socket)
      info "started client"
    else
      info "Received invalid WebSocket request for: #{socket.url}"
      socket.close
    end
  end
end
