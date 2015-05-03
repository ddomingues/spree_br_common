Spree::Core::Engine.routes.draw do
  namespace :api, :defaults => { :format => 'json' } do
    resources :cities, :only => [:index, :show]
  end
end
