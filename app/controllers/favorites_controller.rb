class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @picture = Picture.find(params[:picture_id])
    current_user.favorite(@picture)
    redirect_back(fallback_location: root_url) 
  end
  
  def destroy
    @picture = Picture.find(params[:picture_id])
    current_user.unfavorite(@picture)
    redirect_back(fallback_location: root_url) 
  end
end
