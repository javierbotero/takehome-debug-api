# frozen_string_literal: true

class User < ApplicationRecord
  has_many :hits

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def count_hits
    monthly_hits
  end

  def self.reset_monthly_hits!(timezone, offset)
    if offset.negative?
      offset_date = Time.now + (60 * 60 * offset.abs + 1)

      return unless offset_date.month > Time.now.month
    end

    where(timezone:).update_all(monthly_hits: 0)
  end
end
