Hydra::ObjectViewer::Engine.routes.draw do
  match ':id' => 'application#show', :as => :show
end
