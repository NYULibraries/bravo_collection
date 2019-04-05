class Collection < ApplicationRecord
  has_many :videos
  validates :title, :description, :presence => true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  has_attached_file :image, :default_url => "/system/collections/default_collection.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def slug_candidates
    [
      :title,
      [:title, :id]
    ]
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
