# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:reviews) { FactoryBot.create_list :review, 10 }

  describe 'GET index' do
    context 'without filter group' do
      it 'renders error' do
        get :index, params: { format: 'html' }
        expect(flash[:notice]).to eq(I18n.t('reviews.errors.group'))
      end
    end

    context 'without format' do
      it 'renders error' do
        get :index, params: { group_by: Review::AVAILABLE_GROUPS.sample }
        expect(flash[:notice]).to eq(I18n.t('reviews.errors.format'))
      end
    end

    context 'with invalid filter group' do
      it 'assigns first filter group and renders html template' do
        get :index, params: { group_by: 'invalid', format: 'html' }
        expect(response).to render_template(:index)
        expect(assigns(:reviews)).to include(
          reviews.group_by { |r| r.send(Review::AVAILABLE_GROUPS.first) }
        )
      end
    end

    Review::AVAILABLE_GROUPS.each do |filter_group|
      context "#{filter_group} filter group" do
        it 'assigns correct filter group and renders html template' do
          get :index, params: { group_by: filter_group, format: 'html' }
          expect(response).to render_template(:index)
          expect(assigns(:reviews)).to include(
            reviews.group_by { |r| r.send(filter_group) }
          )
        end

        it 'assigns correct filter group and renders xlsx template' do
          get :index, params: { group_by: filter_group, format: 'xlsx' }
          expect(response.content_type).to match /application\/vnd\.openxmlformats*/
          expect(assigns(:reviews)).to include(
            reviews.group_by { |r| r.send(filter_group) }
          )
        end
      end
    end
  end

  describe 'POST upload' do
    context 'without file' do
      it 'renders error' do
        post :upload
        expect(flash[:notice]).to eq(I18n.t('reviews.errors.file'))
      end
    end

    it 'uploads a file' do
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/report.csv'), 'text/csv')
      post :upload, params: { file: file }
      expect(response).to redirect_to(root_path)
    end
  end
end
