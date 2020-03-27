# frozen_string_literal: true

task update_sentiments: :environment do
  reviews = Review.where(emotion: nil).order(:id).pluck(:id, :text)

  uri = URI(ENV['PARALLELDOTS_BASE_URL'] + '/emotion_batch')

  request = Net::HTTP::Post.new uri
  request.set_form_data(
    api_key: ENV['PARALLELDOTS_API_KEY'],
    text: reviews.map { |r| r[1] }.to_json
  )

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request request
  end

  unless response.is_a?(Net::HTTPSuccess)
    binding.pry
    raise response.value
  end

  ActiveRecord::Base.transaction do
    reviews.each.with_index do |review, index|
      emotion = JSON.parse(response.body)['emotion'][index].max.first.downcase
      Review.find(review[0]).update! emotion: emotion
    end
  end
end
