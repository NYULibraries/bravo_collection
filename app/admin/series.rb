ActiveAdmin.register Series do
  permit_params :title, :description, :table, :finding_aid_id
  active_admin_import

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    column :title
    column :finding_aid
    column "Description" do |series|
      truncate(series.description, omission: "...", length: 200, escape: false)
    end
    actions
  end
  form do |f|
    inputs 'Details' do
      input :title
      input :finding_aid
      input :description
      input :table, :hint => "Cut and paste html table, without scope note"
      li "Created at #{f.object.created_at}" unless f.object.new_record?
      actions
    end
  end


end
