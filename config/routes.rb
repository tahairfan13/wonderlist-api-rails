Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api ,defaults: {format: 'json'} do
    
    scope module: 'authenticate',path: 'auth' do
      post '/sign_up', to: 'registrations#create'
      post '/sign_in',to: 'sessions#create'
      delete '/destroy',to: 'registrations#destroy'
      delete '/sign_out', to: 'sessions#destroy'
    end

    # namespace :auth do
    #   post '/sign_up', to: 'registrations#create'
    #   post '/sign_in',to: 'sessions#create'
    #   delete '/destroy',to: 'registrations#destroy'
    #   delete '/sign_out', to: 'sessions#destroy'

    # end  


    put '/users/edit_profile',to: 'users#update'
    

    resources :lists do
      resources :tasks
    end

    resources :documents , only: [:show,:create,:destroy]


    get '/admin/users', to: 'admin_services#index'
    put '/admin/users/:id/change_status', to: 'admin_services#change_user_status'
    put '/admin/users/:id/make_admin', to: 'admin_services#make_admin'
  end
end
