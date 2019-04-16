class Document < ApplicationRecord
  validates :title, :description, :document_file_file_name,  :presence => true
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  has_attached_file :document_file
  validates_attachment_content_type :document_file, content_type: ['application/pdf']

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
