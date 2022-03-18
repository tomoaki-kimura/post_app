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
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      flash[:success] = "編集しました"
      redirect_to @picture
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @picture = Picture.find(params[:id])
    flash[:success] = "削除しました"
    @picture.destroy if @picture
    redirect_to root_url
  end
  
  private

  def picture_params
    params.require(:picture).permit(:title, :description, :picture)
  end
end