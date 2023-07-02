# frozen_string_literal: true

module PrivateEmbed
  module EmbedControllerInstanceMethods
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

  module TopicEmbedClassMethods
    def find_remote(url)
      url = UrlHelper.normalized_encode(url)
      URI.parse(url) # ensure url parses, will raise if not
      fd = FinalDestination.new(url, validate_uri: true, max_redirects: 5, follow_canonical: true)

      uri = fd.resolve
      return if uri.blank?

      begin
        # You have to set up the following hidden settings for this to work
        # SiteSetting.cache_onebox_response_body
        # SiteSetting.cache_onebox_response_body_domains
        html = Oneboxer.fetch_cached_response_body(uri) or uri.read
      rescue OpenURI::HTTPError, Net::OpenTimeout
        return
      end

      parse_html(html, uri.to_s)
    end
  end
end
