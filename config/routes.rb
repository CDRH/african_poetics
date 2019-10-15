Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get '/country', to: 'general#country', as: 'country'

  scope "/contemporarypoets" do
    get '/', to: 'contemporarypoets#home', as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    # Faked Featured Section for now
    get '/browse/featured', to: 'contemporarypoets#featured', 
      as: 'featured', defaults: { section: "contemporarypoets" }

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
    get '/', to: 'about#homeabout', 
      as: 'about_homeabout', defaults: { section: "about" }
    get '/africanpoetrybookfund', to: 'about#africanpoetrybookfund', 
      as:  'about_africanpoetrybookfund', defaults: { section: "about" }
    get '/technicaldetails', to: 'about#technicaldetails', 
      as:  'about_technicaldetails', defaults: { section: "about" }

  end


  
end
