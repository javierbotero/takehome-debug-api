# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :timezone, null: false, default: 'America/New_York'
      t.integer :monthly_hits, null: false, default: 0

      t.timestamps
    end
  end
end
