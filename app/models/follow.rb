class Follow < ApplicationRecord
  validates :inverse_follower_id, uniqueness: { scope: :follower_id }
end
