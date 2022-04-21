class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @picture = Picture.find(params[:picture_id])
    current_user.favorite(@picture)
  end
  
  def destroy
    @picture = Picture.find(params[:picture_id])
    current_user.unfavorite(@picture)
  end
end
