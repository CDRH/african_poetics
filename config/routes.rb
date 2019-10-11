Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get '/country', to: 'general#country', as: 'country'

  scope "/contemporarypoets" do
    get '/', to: 'contemporarypoets#home', as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    get '/browse/country', to: 'contemporarypoets#browse_country', 
      as: 'country', defaults: { section: "contemporarypoets" }
    get '/browse/region', to: 'contemporarypoets#browse_region', 
      as: 'region', defaults: { section: "contemporarypoets" }

    # Faked Featured Section for now
    get '/browse/featured', to: 'contemporarypoets#featured', 
      as: 'featured', defaults: { section: "contemporarypoets" }

    get '/featured/Ama_Ata_Aidoo', to: 'contemporarypoets#featured_Ama_Ata_Aidoo', 
      as: 'featured_Ama_Ata_Aidoo', defaults: { section: "contemporarypoets" }
    get '/featured/Gabriel_Okara', to: 'contemporarypoets#featured_Gabriel_Okara', 
      as: 'featured_Gabriel_Okara', defaults: { section: "contemporarypoets" }
    get '/featured/Kofi_Awoonor', to: 'contemporarypoets#featured_Kofi_Awoonor', 
      as: 'featured_Kofi_Awoonor', defaults: { section: "contemporarypoets" }
    get '/featured/Ladan_Osman', to: 'contemporarypoets#featured_Ladan_Osman', 
      as: 'featured_Ladan_Osman', defaults: { section: "contemporarypoets" }
    get '/featured/Mahtem_Shiferraw', to: 'contemporarypoets#featured_Mahtem_Shiferraw', 
      as: 'featured_Mahtem_Shiferraw', defaults: { section: "contemporarypoets" }

    Orchid::Routing.draw(section: 'contemporarypoets',
      routes: ["browse", "browse_facet", "search", "item"], scope: '/contemporarypoets')
  end

  scope "/inthenews" do
    get '/', to: 'inthenews#home', as: :inthenews_home,
      defaults: { section: "inthenews" }

    Orchid::Routing.draw(section: 'inthenews',
      routes: ["browse", "browse_facet", "search"], scope: '/inthenews')
  end

  scope "/about" do
    get '/', to: 'about#homeabout', as: :about_homeabout, defaults: { section: "about" }
    get '/africanpoetrybookfund', to: 'about#africanpoetrybookfund', as: 
      :about_africanpoetrybookfund, defaults: { section: "about" }

  end


  
end
