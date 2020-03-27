# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :author_name, null: false
      t.integer :author_gender, null: false
      t.string :city, null: false
      t.text :text, null: false
      t.datetime :date, null: false
      t.integer :emotion, null: false

      t.timestamps
    end
  end
end
