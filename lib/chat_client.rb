require 'celluloid/autostart'
require 'uuidtools'
require_relative 'highlight'

class ChatClient
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Logger

  def initialize(websocket, chat_logger)
    @chat_logger = chat_logger
    puts "Chat client joined"
    @socket = websocket
    subscribe("chat", :handle_chat)
    subscribe("video", :handle_video)
    play_back_history
    @uuid = UUIDTools::UUID.random_create
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
    when "video"
      message = {"type" => "video", "data" => {"uuid" => @uuid.to_s, "video_data" => message["data"]}}
      publish("video", message)
    end
  end

  def handle_video(topic, message)
    return if message["data"]["uuid"] == @uuid.to_s
    write(message)
  end

  def handle_chat(topic, message)
    message["data"]["body"] = Highlight.highlight(message["data"]["body"])
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

  def play_back_history
    @chat_logger.history.each do |message|
      handle_chat(nil, {"type" => "chat", "data" => {"username" => message.user.email, "body" => message.body}})
    end
  end
end
