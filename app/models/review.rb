# frozen_string_literal: true

class Review < ApplicationRecord
  GENDERS = %i[male female].freeze
  EMOTIONS = %i[happy angry excited sad fear bored].freeze

  AVAILABLE_GROUPS = %w[author_gender city emotion month time_of_day].freeze
  AVAILABLE_FORMATS = %w[xlsx html].freeze

  enum author_gender: GENDERS
  enum emotion: EMOTIONS

  validates :author_name, :author_gender, :city, :text, :date, :emotion, presence: true

  def month
    Date::MONTHNAMES[date.month]
  end

  def time_of_day
    case date.hour
    when 6..11
      'Morning'
    when 12..17
      'Day'
    when 17..20
      'Evening'
    else
      'Night'
    end
  end
end
