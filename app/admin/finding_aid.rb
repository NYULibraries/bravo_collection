ActiveAdmin.register FindingAid do
  permit_params :creator, :title, :header, :dates_inclusive, :dates_bulk, :abstract, :quantity, :location_note, :language, :call_phrase, :historical_note, :scope_note, :access_points, :administrative_information, :arrangement, :image 
  active_admin_import

  
  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end


  index do
    column :creator
    column :title
    column "Abstract" do |song|
      truncate(song.abstract, omission: "...", length: 200, escape: false)
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :creator
      input :title
      input :image, :as => :file, :hint => object.image.present? ? image_tag(object.image.url) : content_tag(:span, "no image uploaded yet")
      input :dates_inclusive
      input :dates_bulk
      input :abstract
      input :quantity
      input :location_note
      input :language
      input :call_phrase
      input :header 
      input :historical_note
      input :scope_note
      input :arrangement
      input :access_points
      input :administrative_information 

      actions
    end
  end
end
