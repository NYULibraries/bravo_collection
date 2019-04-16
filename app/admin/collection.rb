ActiveAdmin.register Collection do
  permit_params :title, :description, :slug, :image
  active_admin_import

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    column :title
    column "Description" do |collection|
      truncate(collection.description, omission: "...", length: 200, escape: false)
    end
    actions
  end
  form do |f|
    inputs 'Details' do
      input :title
      input :slug
      input :description
      input :image, :as => :file, :hint => object.image.present? ? image_tag(object.image.url) : content_tag(:span, "no image uploaded yet")
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
  end
end
