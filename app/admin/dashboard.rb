ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Videos" do
          table_for Video.limit(5) do
            column :name do |video|
              link_to video.name, [:admin, video]
            end
            column :title do |video|
              link_to video.title, [:admin, video]
            end
            column "Description" do |video|
              truncate(video.description, omission: "...", length: 200, escape: false)
            end
          end
          strong { link_to "View All Videos", admin_videos_path }
        end
        panel "Recent Films" do
          table_for Film.limit(5) do
            column :title do |film|
              link_to film.title, [:admin, film]
            end
            column "Description" do |film|
              truncate(film.description, omission: "...", length: 200, escape: false)
            end
          end
          strong { link_to "View All Films", admin_films_path }
        end
      end
    end
  end
end
