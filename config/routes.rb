Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }
  namespace :public do
    root 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    resources :customers, only:[:show, :edit, :update]
    get 'custmers/unsubscribe' => 'customers#unsubscribe'
    patch 'custmers/withdraw' => 'customers#withdraw'
    resources :cart_itrms, only:[:index, :create, :update, :destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :orders, only:[:new, :index, :create, :show]
    post 'orders/comfirm' => 'orders#comfirm'
    get 'orders/complete' => 'orders#complete'
    resources :adresses, only:[:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
