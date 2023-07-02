# frozen_string_literal: true

# name: discourse-private-embed
# about: Better Discourse embedding for private instances
# version: 0.0.1
# authors: yaegashi
# url: https://github.com/yaegashi/discourse-private-embed

after_initialize do
  require_relative 'lib/private_embed'

  class ::EmbedController
    prepend PrivateEmbed::EmbedControllerInstanceMethods
    skip_before_action :redirect_to_login_if_required
    append_view_path File.expand_path('../app/views', __FILE__)
  end

  class ::TopicEmbed
    singleton_class.prepend PrivateEmbed::TopicEmbedClassMethods
  end
end
