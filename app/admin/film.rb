ActiveAdmin.register Film do
  permit_params :title, :description, :year, :duration, :slug, :thumbnail
  active_admin_import

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    column :title
    column :year
    column "Description" do |film|
      truncate(film.description, omission: "...", length: 200, escape: false)
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :title
      input :slug
      input :thumbnail, :as => :file, :hint => object.thumbnail.present? ? image_tag(object.thumbnail.url) : content_tag(:span, "no image uploaded yet")
      input :year
      input :duration, :hint => "Enter number of minutes, just the digits, ex. 90"
      input :description
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
  end  
end
