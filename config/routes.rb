Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/country', to: 'general#country', as: 'country'
  
  # temp about pages
  get '/about_africanpoetrybookfund', to: 'general#about_africanpoetrybookfund', as: 'about_africanpoetrybookfund'

  # temp cap home page
  
  #get '/index_contemporarypoets', to: 'general#index_contemporarypoets', as: 'index_contemporarypoets'

  #landing page for "in the news" (not developed yet)
  # get '/inthenews', to: 'general#inthenews', as: 'inthenews'

  scope "/contemporarypoets" do
    get '/', to: 'contemporarypoets#home', as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    Orchid::Routing.draw(section: 'contemporarypoets',
      routes: ["browse", "browse_facet", "search", "item"], scope: '/contemporarypoets')
  end

  scope "/inthenews" do
    get '/', to: 'inthenews#home', as: :inthenews_home,
      defaults: { section: "inthenews" }

    Orchid::Routing.draw(section: 'inthenews',
      routes: ["browse", "browse_facet", "search"], scope: '/inthenews')
  end


  
end
