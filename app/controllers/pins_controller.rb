class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user?, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all.order("created_at DESC").paginate( page: params[:page], per_page: 4)
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
   @pin = current_user.pins.build(pin_params)
    if @pin.save
      flash[:success] = "Sweet. You have a new pin!"
      redirect_to @pin
    else
      render action: 'new'
    end
  end

  def update
    @pin.update(pin_params)
  end

  def destroy
    @pin.destroy
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user?
      @pin = current_user.pins.find_by(id: params[:id])
      if @pin.nil?
        flash[:danger] = "You are not permitted to access this page"
        redirect_to pins_path
      end
    end
    
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
