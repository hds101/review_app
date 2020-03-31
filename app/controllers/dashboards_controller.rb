# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @reviews_count = Review.count
  end
end
