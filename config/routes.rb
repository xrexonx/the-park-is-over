Rails.application.routes.draw do
  namespace :api do
    namespace :v1, :defaults => {:format => :json} do
      resources :parking, :only => [:index] do
        collection do
          post :park
          post :unpark
        end
      end
    end
  end
end
