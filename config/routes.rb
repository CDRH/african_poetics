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

    Orchid::Routing.draw(section: 'contemporarypoets',
      routes: ["browse", "browse_facet", "search", "item"], scope: '/contemporarypoets')
  end

  scope "/inthenews" do
    get '/', to: 'inthenews#home', as: :inthenews_home,
      defaults: { section: "inthenews" }

    # Wireframes
    get '/poets', to: 'inthenews#poets', as: :inthenews_poets,
      defaults: { section: "inthenews" }
    get '/events', to: 'inthenews#events', as: :inthenews_events,
      defaults: { section: "inthenews" }
    get '/news', to: 'inthenews#news', as: :inthenews_news,
      defaults: { section: "inthenews" }
    get '/relationships', to: 'inthenews#relationships', as: :inthenews_relationships,
      defaults: { section: "inthenews" }
    get '/about', to: 'inthenews#about', as: :inthenews_about,
      defaults: { section: "inthenews" }

    get '/poets/wolesoyinkamain', to: 'inthenews#wolesoyinkamain', as: :inthenews_wolesoyinkamain,
      defaults: { section: "inthenews" }
    get '/poets/wolesoyinkaevents', to: 'inthenews#wolesoyinkaevents', as: :inthenews_wolesoyinkaevents,
      defaults: { section: "inthenews" }

    get '/events/ap.ev.001', to: 'inthenews#event001', as: :inthenews_event001,
      defaults: { section: "inthenews" }
    get '/events/ap.item.001', to: 'inthenews#item001', as: :inthenews_item001,
      defaults: { section: "inthenews" }

      

    Orchid::Routing.draw(section: 'inthenews',
      routes: ["browse", "browse_facet", "search"], scope: '/inthenews')
  end

  scope "/about" do
    get '/', to: 'about#homeabout', 
      as: 'about_homeabout', defaults: { section: "about" }
    get '/africanpoetrybookfund', to: 'about#africanpoetrybookfund', 
      as:  'about_africanpoetrybookfund', defaults: { section: "about" }
    get '/technicaldetails', to: 'about#technicaldetails', 
      as:  'about_technicaldetails', defaults: { section: "about" }

  end


  
end
