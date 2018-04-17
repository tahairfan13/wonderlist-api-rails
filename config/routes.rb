Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api ,defaults: {format: 'json'} do
    post '/auth/sign_up', to: 'registrations#create'
    post '/auth/sign_in',to: 'sessions#create'
    delete '/auth/destroy',to: 'registrations#destroy'
    delete '/auth/sign_out', to: 'sessions#destroy'

    put '/users/edit_profile',to: 'users#update'
    
    resources :lists do
      resources :tasks
    end

    get '/admin/users', to: 'admin_services#index'
    put '/admin/users/:id/change_status', to: 'admin_services#change_user_status'
    put '/admin/users/:id/make_admin', to: 'admin_services#make_admin'
  end
end
