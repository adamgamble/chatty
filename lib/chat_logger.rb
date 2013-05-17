require_relative '../app/models/user.rb'
require 'celluloid/autostart'
require_relative 'highlight'

class ChatLogger
  include Celluloid
  include Celluloid::Notifications
  include Celluloid::Logger

  def initialize
    async.run
  end

  def run
    subscribe("chat", :handle_chat)
  end

  def handle_chat(topic, message)
    user = ::User.where(:email => message["data"]["username"]).first
    Post.create(:body => message["data"]["body"], :user => user)
    puts "#{message["data"]["username"]}: #{message["data"]["body"]}"
  end

  def history
    Post.all
  end
end
