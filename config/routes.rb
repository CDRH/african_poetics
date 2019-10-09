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

    # Faked Featured Section for now
    get '/featured', to: 'contemporarypoets#featured', as: 'featured', defaults: { section: "contemporarypoets" }
    get '/featured/Ama_Ata_Aidoo', to: 'contemporarypoets#featured_Ama_Ata_Aidoo', as: 'featured_Ama_Ata_Aidoo', defaults: { section: "contemporarypoets" }
    get '/featured/Gabriel_Okara', to: 'contemporarypoets#Gabriel_Okara', as: 'featured_Gabriel_Okara', defaults: { section: "contemporarypoets" }
    get '/featured/Kofi_Awoonor', to: 'contemporarypoets#Kofi_Awoonor', as: 'featured_Kofi_Awoonor', defaults: { section: "contemporarypoets" }
    get '/featured/Ladan_Osman', to: 'contemporarypoets#Ladan_Osman', as: 'featured_Ladan_Osman', defaults: { section: "contemporarypoets" }
    get '/featured/Mahtem_Shiferraw', to: 'contemporarypoets#Mahtem_Shiferraw', as: 'featured_Mahtem_Shiferraw', defaults: { section: "contemporarypoets" }

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
