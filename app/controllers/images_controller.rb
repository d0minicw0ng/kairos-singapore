class ImagesController < ApplicationController

  private
  def image_params
    params.require(:image).permit(:avatar)
  end
end
