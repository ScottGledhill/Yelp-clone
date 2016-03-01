class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new

  end

  def create
    Restaurant.create(restaurant_params)
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def show
  @restaurant = Restaurant.find(params[:id])
  end

  def edit
    Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end
end
