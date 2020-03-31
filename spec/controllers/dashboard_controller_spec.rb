# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  let!(:reviews) { FactoryBot.create_list :review, 10 }

  describe 'GET show' do
    it 'renders the template and assigns instance variables' do
      get :show
      expect(response).to render_template(:show)
      expect(assigns(:reviews_count)).to eq(reviews.count)
      expect(assigns(:group_by_options).map { |g| g[1] }).to match_array(Review::AVAILABLE_GROUPS)
      expect(assigns(:format_options).map { |f| f[1] }).to match_array(Review::AVAILABLE_FORMATS)
    end
  end
end
