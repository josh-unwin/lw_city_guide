class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :set_city, only: [:new, :create]

  def new
    @spot = Spot.new
    unless current_user.cities.include?(@city)
      flash[:alert] = "You can't add a spot for #{@city.name}"
      redirect_back(fallback_location: root_path)
    end
    authorize @spot
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    @spot.city = @city
    if @spot.save
      redirect_to @spot
    else
      render :new
    end
    authorize @spot
  end

  def show
    @rating = Rating.where(user: current_user, spot: @spot).first || Rating.new
  end

  def edit
  end

  def update
    if @spot.update(spot_params)
      redirect_to spot_path(@spot)
    else
      render :edit
    end
  end

  def destroy
    @spot.destroy
    redirect_to city_path(@spot.city)
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
    authorize @spot
  end

  def set_city
    @city = City.find(params[:city_id])
  end

  def spot_params
    params.require(:spot).permit(:name, :category, :sub_category, :description, :address, :latitude, :longitude, :phone_number, :website, :photo)
  end
end
