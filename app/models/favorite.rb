class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :film

  # Method to add a film to a user's favorites
  def self.add_favorite(user, film)
    Favorite.create(user: user, film: film) unless Favorite.exists?(user: user, film: film)
  end

  # Method to remove a film from a user's favorites
  def self.remove_favorite(user, film)
    favorite = Favorite.find_by(user: user, film: film)
    favorite.destroy if favorite
  end
end
