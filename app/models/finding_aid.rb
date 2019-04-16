class FindingAid < ApplicationRecord
  has_many :series
  has_attached_file :image, :default_url => "/system/finding_aids/default_fa.jpg"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end 
end
