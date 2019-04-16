class Video < ApplicationRecord
  belongs_to :film
  belongs_to :collection
  validates :title, :name, :description, :embed, :presence => true
  extend FriendlyId
  friendly_id :friendly_name, use: :slugged
  has_attached_file :thumbnail, :styles => { :small => "300x300>" }, :default_url => "/system/videos/default_video.jpg"
  validates_attachment_content_type :thumbnail, content_type: ['image/jpeg']
  has_attached_file :transcript
  validates_attachment_content_type :transcript, content_type: ['application/pdf']


  def friendly_name
    self.name+'-'+self.title
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
