Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'

  resources :collections, except: [:new, :create, :edit, :update, :destroy]
  resources :documents, except: [:new, :create, :edit, :update, :destroy]
  resources :films, except: [:new, :create, :edit, :update, :destroy]
  resources :finding_aids, except: [:new, :create, :edit, :update, :destroy]
  resources :series, except: [:new, :create, :edit, :update, :destroy]
  resources :videos, except: [:new, :create, :edit, :update, :destroy]
  
  root "static_pages#home"
  get "video-histories-of-the-cuban-revolution" => "collections#VHCR"

  #Static pages
  get "bravo-collection" => "static_pages#bravo_collection"
  get "contact" => "static_pages#contact" 
  get "estela-bravo" => "static_pages#estela_bravo"
  get "tamiment-library" => "static_pages#tamiment_library"
  get "video-rights" => "static_pages#video_rights"

end
