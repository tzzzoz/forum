require File.expand_path('../boot', __FILE__)

# require 'uri'
# if ENV['MONGOHQ_URL']
#   mongo_uri = URI.parse(ENV['MONGOHQ_URL'])
#   ENV['MONGOID_HOST'] = mongo_uri.host
#   ENV['MONGOID_PORT'] = mongo_uri.port.to_s
#   ENV['MONGOID_USERNAME'] = mongo_uri.user
#   ENV['MONGOID_PASSWORD'] = mongo_uri.password
#   ENV['MONGOID_DATABASE'] = mongo_uri.path.gsub('/', '')
# end

require 'mongoid/railtie'
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Dream
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js rails http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.7/jquery-ui.min.js application)
    config.action_view.javascript_expansions[:defaults] = %w(jquery.min.js rails jquery-ui.min.js autocomplete-rails.js)
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
  end
end
