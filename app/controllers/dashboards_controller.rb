# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @review_count = Review.count
  end
end
