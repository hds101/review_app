# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    author_name { Faker::Name.name }
    author_gender { Review::GENDERS.sample }
    city { Faker::Address.city }
    text { Faker::Lorem.paragraph(sentence_count: 4) }
    date { Faker::Date.in_date_period }
    emotion { Review::EMOTIONS.sample }
  end
end
