# frozen_string_literal: true

class Review < ApplicationRecord
  GENDERS = %i[male female].freeze
  EMOTIONS = %i[happy angry excited sad fear bored].freeze

  enum author_gender: GENDERS
  enum emotion: EMOTIONS

  validates :author_name, :author_gender, :city, :text, :date, :emotion, presence: true
end
