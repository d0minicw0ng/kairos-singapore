class StaticsController < ApplicationController

  def about
  end

  def fellows
  end

  def contact
  end

  def contact_us
    EmailWorker.perform_async('ContactUsMailer', :contact_us, params)
    render json: {}, status: 200
  end
end
