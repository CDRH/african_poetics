Rails.application.routes.draw do

  with_period = /[^\/]+/
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/country", to: "general#country", as: "country"

  get "/criticalbibliographies", to: "general#criticalbibliographies", as: "criticalbibliographies"
  get "/dhgrant", to: "general#dhgrant"

  scope "/contemporarypoets" do
    get "/", to: "contemporarypoets#home", as: :contemporarypoets_home,
      defaults: { section: "contemporarypoets" }

    get "/about", to: "contemporarypoets#about",
      as: "contemporarypoets_about", defaults: { section: "contemporarypoets" }

    get "/about/consultedsources", to: "contemporarypoets#about_consultedsources",
      as: "contemporarypoets_about_consultedsources", defaults: { section: "contemporarypoets" }

    get "/about/criteria", to: "contemporarypoets#about_criteria",
      as: "contemporarypoets_about_criteria", defaults: { section: "contemporarypoets" }

    Orchid::Routing.draw(section: "contemporarypoets",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/contemporarypoets")
  end

  scope "/inthenews" do

    get "/", to: "inthenews#home", as: :inthenews_home,
      defaults: { section: "inthenews" }
    get "/about", to: "inthenews#about", as: :inthenews_about,
      defaults: { section: "inthenews" }
    get "/about/credits", to: "inthenews#about_credits",
      as: "inthenews_about_credits", defaults: { section: "inthenews" }
    get "/visualizations", to: "inthenews#visualizations",
      as: "inthenews_visualizations", defaults: { section: "inthenews" }
    get "/criticalbibliographies", to: "inthenews#criticalbibliographies",
      as: "inthenews_criticalbibliographies", defaults: { section: "inthenews" }

    # commentaries
    Orchid::Routing.draw(section: "inthenewscommentaries",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/inthenews/commentaries")
    get "/commentaries", to: "inthenewscommentaries#home", as: :inthenewscommentaries,
      defaults: { section: "inthenewscommentaries" }

    # events
    Orchid::Routing.draw(section: "inthenewsevents",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/inthenews/events")
    get "/events", to: "inthenewsevents#home", as: :inthenewsevents,
      defaults: { section: "inthenewsevents" }

    # news items
    Orchid::Routing.draw(section: "inthenewsnewsitems",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/inthenews/news")
    get "/news", to: "inthenewsnewsitems#home", as: :inthenewsnewsitems,
      defaults: { section: "inthenewsnewsitems" }

    # poets
    Orchid::Routing.draw(section: "inthenewspoets",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/inthenews/poets")
    get "/poets", to: "inthenewspoets#home", as: :inthenewspoets,
      defaults: { section: "inthenewspoets" }

    # works
    Orchid::Routing.draw(section: "inthenewsworks",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/inthenews/works")
    get "/works", to: "inthenewsworks#home", as: :inthenewsworks,
      defaults: { section: "inthenewsworks" }

    # leftover from the wireframes but not actually used
    get "/relationships", to: "inthenews#relationships", as: :inthenews_relationships,
      defaults: { section: "inthenews" }

  end

  scope "/about" do
    get "/", to: "about#home",
      as: "about_home", defaults: { section: "about" }
    get "/credits", to: "about#credits",
      as: "about_credits", defaults: { section: "about" }
    get "/africanpoetrybookfund", to: "about#africanpoetrybookfund",
      as:  "about_africanpoetrybookfund", defaults: { section: "about" }
    get "/technicaldetails", to: "about#technicaldetails",
      as:  "about_technicaldetails", defaults: { section: "about" }

  end

end
