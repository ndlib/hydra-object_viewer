Rails.application.routes.draw do

  mount Hydra::ObjectViewer::Engine => "/show"
end
