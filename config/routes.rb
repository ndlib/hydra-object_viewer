Hydra::ObjectViewer::Engine.routes.draw do
  get ':id' => 'application#show', :as => :show
end
