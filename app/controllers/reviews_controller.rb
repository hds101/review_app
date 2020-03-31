# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :validate_filter, only: :index
  before_action :validate_file, only: :upload

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
    redirect_to root_path
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

  def validate_filter
    return if filter_params[:format].present? && filter_params[:group_by].present?

    errors = []
    errors << 'Select report format' if filter_params[:format].blank?
    errors << 'Select group clause' if filter_params[:group_by].blank?

    redirect_to root_path, notice: errors.join(', ')
  end

  def validate_file
    redirect_to root_path, notice: 'Select a file to upload' if upload_params[:file].blank?
  end
end
