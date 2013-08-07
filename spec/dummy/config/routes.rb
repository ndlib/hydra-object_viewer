Rails.application.routes.draw do

  mount Hydra::ObjectViewer::Engine => "/hydra/object_viewer"
end
