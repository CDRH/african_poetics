# override default Orchid routing to avoid generic unscoped routes, which lead to errors or jumbled info

Rails.application.routes.draw do

  with_period = /[^\/]+/
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/country", to: "general#country", as: "country"

  get "/dhgrant", to: "general#dhgrant"
  get "/dhprojects", to: "general#dhprojects"

  scope "/index-of-poets" do
    get "/", to: "index_of_poets#home", as: :index_of_poets_home,
      defaults: { section: "index_of_poets" }

    get "/about", to: "index_of_poets#about",
      as: "index_of_poets_about", defaults: { section: "index_of_poets" }

    get "/about/consultedsources", to: "index_of_poets#about_consultedsources",
      as: "index_of_poets_about_consultedsources", defaults: { section: "index_of_poets" }

    get "/about/criteria", to: "index_of_poets#about_criteria",
      as: "index_of_poets_about_criteria", defaults: { section: "index_of_poets" }

    Orchid::Routing.draw(section: "index_of_poets",
      routes: ["browse", "browse_facet", "search", "item"], scope: "/index-of-poets")
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
    get "/bibliographies", to: "inthenews#bibliographies",
      as: "inthenews_bibliographies", defaults: { section: "inthenews" }

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

  scope "/bibliographies" do
    get "/", to: "bibliographies#home",
      as: "bibliographies", defaults: { section: "bibliographies" }
    get "/kofi-awoonor", to: "bibliographies#kofi-awoonor",
      as: "bibliographies_kofi_awoonor", defaults: { section: "bibliographies" }
    get "tanella-boni", to: "bibliographies#tanella-boni",
      as: "bibliographies_tanella_boni", defaults: { section: "bibliographies" }
    get "keorapetse-kgositsile", to: "bibliographies#keorapetse-kgositsile",
      as: "bibliographies_keorapetse_kgositsile", defaults: { section: "bibliographies" }
    get "antjie-krog", to: "bibliographies#antjie-krog",
      as: "bibliographies_antjie_krog", defaults: { section: "bibliographies" }
    get "gabriel-okara", to: "bibliographies#gabriel-okara",
      as: "bibliographies_gabriel_okara", defaults: { section: "bibliographies" }
    get "wole-soyinka", to: "bibliographies#wole-soyinka",
      as: "bibliographies_wole_soyinka", defaults: { section: "bibliographies" }
  end

  #redefine default routes so they don't show up outside of the sections, where metadata can get confused
  get 'item/:id', to: 'general#item_redir', as: 'item', constraints: { id: with_period }
  get "search", to: 'general#index', as: "search"

end
