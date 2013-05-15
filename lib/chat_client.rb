require 'celluloid/autostart'

class ChatClient
  include Celluloid::IO
  include Celluloid::Notifications
  include Celluloid::Logger

  def initialize(websocket)
    @socket = websocket
    subscribe("chat", :handle_chat)
    async.run
  end

  def run
    sleep 0.1 # Just give the socket a chance to initiate? :(
    while message = JSON.parse(@socket.read)
      dispatch message
    end
  rescue EOFError
    info "left"
    terminate
  end

  def dispatch(message)
    case message["type"]
    when "chat"
      publish("chat", message)
    else
    end
  end

  def handle_chat(topic, message)
    write(message)
  end

  def write(payload)
    @socket << JSON.generate(payload)
  rescue Reel::SocketError
    info "TruCoin::WebsocketsClient disconnected"
    terminate
  rescue Errno::EPIPE
    info "Pipe was broken, terminating"
    terminate
  end
end
