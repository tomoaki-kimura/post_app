class ToppagesController < ApplicationController
  def index
    @pictures = Picture.all
  end
end
