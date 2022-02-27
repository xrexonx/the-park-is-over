Rails.application.routes.draw do
  namespace :api do
    namespace :v1, :defaults => {:format => :json} do
      resources :parking, :only => [:index] do
        collection do
          post :park
          post :un_park
        end
      end

      resources :slot, :only => [:index]
      resources :payment, :only => [:index]
    end
  end
end
