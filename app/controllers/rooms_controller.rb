class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @rooms = Room.decorate
  end

  def show
    @room = Room.find(room_params).decorate
  end

  private
  def room_params
    params.require(:id)
  end
end
