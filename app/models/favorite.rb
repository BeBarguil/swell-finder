class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :beach

  validates :user_id, uniqueness: { scope: :beach_id }
end
