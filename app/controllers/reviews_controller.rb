# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
    @reviews = @reviews.group_by { |review| review.send(filter_group) }

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def upload
    csv = upload_params[:file]
    ReviewBatchProcessor.call(csv)
    # TODO: clear flash, update reviews count using ws
    redirect_to root_path, notice: 'Processing...'
  end

  private

  def filter_group
    return filter_params[:group_by] if filter_params[:group_by].in? Review::AVAILABLE_GROUPS

    Review::AVAILABLE_GROUPS.first
  end

  def filter_params
    params.permit(:format, :group_by)
  end

  def upload_params
    params.permit(:file)
  end
end
