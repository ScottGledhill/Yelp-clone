class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:notice] = 'You have already reviewed this restaurant'
    end
    @review = Review.new
  end

  # def create
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @restaurant.reviews.create(review_params)
  #   redirect_to restaurants_path
  # end

  def create
  @restaurant = Restaurant.find review_params[:restaurant_id]
  @review = @restaurant.build_review review_params, current_user

  if @review.save
    redirect_to restaurants_path
  else
    if @review.errors[:user]
      # Note: if you have correctly disabled the review button where appropriate,
      # this should never happen...
      redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
    else
      # Why would we render new again?  What else could cause an error?
      render :new
    end
  end
end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end
end
