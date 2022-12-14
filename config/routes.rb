Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }
  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information'=> 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :create, :update, :destroy]
    post 'orders/comfirm' => 'orders#comfirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :index, :create, :show]
    resources :addresses, only:[:index, :create, :edit, :update, :destroy]
    resources :genres, only:[:show]
  end
  namespace :admin do
    get 'top' => 'homes#top'
    resources :items, only:[:new, :index, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :orders, only:[:show, :update]
    resources :order_items, only:[:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
