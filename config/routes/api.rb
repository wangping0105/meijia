namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :auth, only: [] do
      collection do
        post :login, :logout
        get :ping
      end
    end
  end
end
