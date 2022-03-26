class PicturesController < ApplicationController
  include FaradayConcern

  def show
    @picture = Picture.find(params[:id])
    if @picture.picture.attached?
      @latitude = @picture.picture.metadata[:latitude]
      @longitude = @picture.picture.metadata[:longitude]
      @agiinfo = reverse_geocode(@latitude, @longitude)[:result]
      @weather = get_weather(@agiinfo[:prefecture][:pcode]) if @agiinfo
    end
    join_place_data
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
  
  def join_place_data
    if @agiinfo && @agiinfo[:local].present?
      @place = [
        @agiinfo[:prefecture][:pname],
        @agiinfo[:municipality][:mname],
        @agiinfo[:local][0][:section],
        @agiinfo[:local][0][:homenumber],
        "付近"
      ].join
    elsif @agiinfo
      @place = [
        @agiinfo[:prefecture][:pname],
        @agiinfo[:municipality][:mname],
        "付近"
      ].join
    end
  end
end