ActiveAdmin.register Document do
  permit_params :title, :year, :description, :slug, :document_file
  active_admin_import

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    column :title
    column "Description" do |document|
      truncate(document.description, omission: "...", length: 200, escape: false)
    end
    actions
  end

  form do |f|
    inputs 'Details' do
      input :title
      input :slug
      input :description
      input :document_file, :as => :file, :hint => object.document_file.present? ? image_tag(object.document_file.url) : content_tag(:span, "no image uploaded yet")
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
end  

end
