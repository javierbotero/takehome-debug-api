class Hit < ApplicationRecord
  belongs_to :user, counter_cache: :monthly_hits
end
