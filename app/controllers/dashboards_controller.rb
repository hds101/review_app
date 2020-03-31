# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @reviews_count = Review.count
    @format_options = Review::AVAILABLE_FORMATS.map { |f| [I18n.t("dashboard.formats.#{f}"), f] }
    @group_by_options = Review::AVAILABLE_GROUPS.map { |g| [I18n.t("dashboard.groups.#{g}"), g] }
  end
end
