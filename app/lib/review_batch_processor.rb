# frozen_string_literal: true

require 'csv'

class ReviewBatchProcessor
  def self.call(csv_path)
    rows = CSV.read(csv_path)
    rows.each_slice(25) do |batch_rows|
      CreateReviewJob.perform_later(batch_rows)
    end
  end
end
