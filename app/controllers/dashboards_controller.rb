class DashboardsController < ApplicationController
  def show
    @reviews = Review.all
  end
end
