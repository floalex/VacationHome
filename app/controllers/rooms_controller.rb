class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @rooms = current_user.rooms
  end

  def show
    @photos = @room.photos
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save

      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      @photos = @room.photos
      
      redirect_to edit_room_path(@room), notice: "Saved.."
    else
      render :new
    end
  end

  def edit
    @photos = @room.photos
  end


  def update
    if @room.update(room_params)

      if params[:images]
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      redirect_to edit_room_path(@room), notice: "Updated.."
    else
      render :edit
    end
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name,
                                   :summary, :address, :has_tv, :has_kitchen, :has_air, :has_heating, :has_internet,
                                   :price, :active)
    end

    def correct_user
      current_user.id == @room.user.id
      redirect_to root_url if @room.nil?
    end
end
