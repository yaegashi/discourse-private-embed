# frozen_string_literal: true

module PrivateEmbed
  module EmbedController
    def topics
      if !current_user && SiteSetting.login_required?
        return render 'login_required'
      end
      super
    end

    def comments
      if !current_user && SiteSetting.login_required?
        return render 'login_required'
      end
      super
    end
  end
end
