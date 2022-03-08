class PicturesController < ApplicationController

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end
  
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:success] = "投稿しました"
      redirect_to @picture
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  private

  def picture_params
    params.require(:picture).permit(:title, :description)
  end
end