# frozen_string_literal: true

class CreateReviewJob < ApplicationJob
  queue_as :default

  def perform(review_batch_rows)
    @rows = review_batch_rows
    fetch_emotions
    create_reviews
    update_reviews_count
  end

  private

  def fetch_emotions
    uri = URI(ENV['PARALLELDOTS_BASE_URL'] + '/emotion_batch')

    request = Net::HTTP::Post.new uri
    # Should also include lang_code: ru, but...
    # You are currently subscribed to the Free plan.
    # Please upgrade your account from your dashboard to use ParallelDots APIs
    # in languages other than English.
    request.set_form_data(
      api_key: ENV['PARALLELDOTS_API_KEY'],
      text: @rows.map { |row| row[3] }.to_json
    )

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request request
    end

    raise response.value unless response.is_a?(Net::HTTPSuccess)

    @emotions = JSON.parse(response.body)['emotion']
  end

  def create_reviews
    ActiveRecord::Base.transaction do
      @rows.each.with_index do |row, index|
        emotion = @emotions[index].max.first.downcase
        Review.create!(
          author_name: row[0],
          author_gender: row[1],
          city: row[2],
          text: row[3],
          emotion: emotion,
          date: DateTime.strptime(row[4], '%s')
        )
      end
    end
  end

  def update_reviews_count
    ActionCable.server.broadcast 'reviews_channel', reviews_count: Review.count
  end
end
