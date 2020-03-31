# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do

  describe 'fields' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:author_name).of_type(:string) }
    it { is_expected.to have_db_column(:author_gender).of_type(:integer) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:text).of_type(:text) }
    it { is_expected.to have_db_column(:emotion).of_type(:integer) }
    it { is_expected.to have_db_column(:date).of_type(:datetime) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:author_gender).with_values(Review::GENDERS) }
    it { is_expected.to define_enum_for(:emotion).with_values(Review::EMOTIONS) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :author_name }
    it { is_expected.to validate_presence_of :author_gender }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :emotion }
    it { is_expected.to validate_presence_of :date }
  end

  describe '.month' do
    let(:review) { FactoryBot.create :review, date: '02.02.2020' }
    it { expect(review.month).to eq(Date::MONTHNAMES[2]) }
  end

  describe '.time_of_day' do
    let(:morning_review) { FactoryBot.create :review, date: '02.02.2020T09:01:10' }
    let(:day_review) { FactoryBot.create :review, date: '02.02.2020T15:01:10' }
    let(:evening_review) { FactoryBot.create :review, date: '02.02.2020T19:01:10' }
    let(:night_review) { FactoryBot.create :review, date: '02.02.2020T02:01:10' }
    it do
      expect(morning_review.time_of_day).to eq('Morning')
      expect(day_review.time_of_day).to eq('Day')
      expect(evening_review.time_of_day).to eq('Evening')
      expect(night_review.time_of_day).to eq('Night')
    end
  end
end
