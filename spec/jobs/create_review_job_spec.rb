# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe CreateReviewJob, type: :job do
  let(:csv_rows) { CSV.read(Rails.root.join('spec/fixtures/report.csv')) }
  let(:pdots_url) { ENV['PARALLELDOTS_BASE_URL'] + '/emotion_batch' }
  let(:pdots_response) do
    {
      'emotion' => [
        {
          'Bored' => '0.076',
          'Angry' => '0.2324',
          'Sad' => '0.3243',
          'Fear' => '0.34341',
          'Happy' => '0.777',
          'Excited' => '0.54342'
        },
        {
          'Bored' => '0.076',
          'Angry' => '0.2324',
          'Sad' => '0.3243',
          'Fear' => '0.34341',
          'Happy' => '0.777',
          'Excited' => '0.54342'
        }
      ]
    }.to_json
  end

  describe '#perform' do
    it 'processes parsed csv' do
      stub_request(:post, "https://apis.paralleldots.com/v4/emotion_batch")
        .with(body: { api_key: '', text: csv_rows.map { |r| r[3] }.to_json })
        .to_return(status: 200, body: pdots_response, headers: {})
      subject.perform(csv_rows)
      expect(Review.count).to eq(2)
    end
  end
end
