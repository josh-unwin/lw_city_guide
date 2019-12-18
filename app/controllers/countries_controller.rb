class CountriesController < ApplicationController
  def new
    authorize @country
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    authorize @country
    if @country.save
      flash[:notice] = "Yay! You successfully created #{@country.name}! 🍪"
      reditrect_to root_path
    else
      flash[:alert] = "Hm, it looks like something went wrong. Please, try again. 🌈"
      render :new
    end
  end

  private

  def country_params
    params.require(:country).permit(:name)
  end
end
