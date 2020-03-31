# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsChannel, type: :channel do
  before do
    stub_connection
  end

  it 'subscribes to a stream' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('reviews_channel')
  end
end

