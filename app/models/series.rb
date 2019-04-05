class Series < ApplicationRecord
  belongs_to :finding_aid
  validates :title, :table, :presence => true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

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
