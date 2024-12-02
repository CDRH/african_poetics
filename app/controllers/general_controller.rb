class GeneralController < ApplicationController

    def item_redir
        #preventing items from being shown outside a scope/section, just go to main page
        render_overridable("general", "index")
    end

end