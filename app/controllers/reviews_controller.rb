# frozen_string_literal: true

class ReviewsController < ApplicationController
  def upload
    csv = upload_params[:file]
    ReviewBatchProcessor.call(csv)
    # TODO: ws
    redirect_to root_path, notice: 'Processing...'
  end

  private

  def upload_params
    params.permit(:file)
  end
end
