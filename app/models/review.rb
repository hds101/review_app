# frozen_string_literal: true

class Review < ApplicationRecord
  GENDERS = %i[male female].freeze
  EMOTIONS = %i[happy angry excited sad fear bored].freeze
  AVAILABLE_GROUPS = %w[author_gender city emotion month time_of_day].freeze

  enum author_gender: GENDERS
  enum emotion: EMOTIONS

  validates :author_name, :author_gender, :city, :text, :date, :emotion, presence: true

  def month
    Date::MONTHNAMES[date.month]
  end

  def time_of_day
    case date.hour
    when 6..11
      'morning'
    when 12..17
      'day'
    when 17..20
      'evening'
    else
      'night'
    end
  end
end
