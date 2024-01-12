class Film < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_one_attached :video
  has_one_attached :thumbnail

  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user

  has_many :comments

  def self.from_table(table)
    table.hashes.each { |row| f = Film.create(row) }
  end

  def film_url
    rails_blob_path(video, only_path: true) if video.attached?
  end

  def thumbnail_url
    rails_blob_path(thumbnail, only_path: true) if thumbnail.attached?
  end

  def owned_by?(user)
    self.user == user
  end
  
end
