class StaticsController < ApplicationController

  def about
  end

  def fellows
  end

  def contact
  end

  def contact_us
    render json: {}, status: 200
  end
end
