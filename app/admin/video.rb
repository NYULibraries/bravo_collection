ActiveAdmin.register Video do
  permit_params :title, :description, :duration, :name, :embed, :film_id, :collection_id, :slug, :thumbnail, :transcript, :year, :refid
  active_admin_import

  batch_action :vhcr do |ids|
    Video.friendly.find(ids).each do |video|
      video.collection_id = "1"
      video.save
    end
    redirect_to collection_path, alert: "The videos have been added to VHCR."
  end
  
  batch_action :fidel do |ids|
    Video.friendly.find(ids).each do |video|
      video.film_id = "1"
      video.save
    end
    redirect_to collection_path, alert: "The videos have been added to Fidel."
  end


  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    selectable_column
    column :name
    column :refid
    column :title
    column :film
    column :collection
    column :slug
    column "Description" do |video|
      truncate(video.description, omission: "...", length: 200, escape: false)
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :name, :hint => "The person or people being interviewed, ex. 'Angela Davis'"
      input :title, :hint => "Short, overall subject of the interview, will appear after the name, ex.'Cuban Artists in the 50s'"
      input :year
      input :refid
      input :duration, :hint => "Enter as HH:MM:SS, ex. '01:13:02'"
      input :embed, :input_html => { :rows => 5, :cols => 10  }
      input :thumbnail, :as => :file, :hint => object.thumbnail.present? ? image_tag(object.thumbnail.url) : content_tag(:span, "no image uploaded yet")
      input :transcript, :as => :file, :hint => object.transcript.present? ? object.transcript.original_filename : content_tag(:span, "no transcript uploaded yet")
      input :film
      input :collection
      input :description
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
  end
end
