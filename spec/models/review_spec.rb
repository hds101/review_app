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
end
