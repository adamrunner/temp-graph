require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TempGraph
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Pacific Time (US & Canada)'
    config.active_job.queue_adapter = :sidekiq
    config.autoload_paths << "#{Rails.root}/app/workers"
    config.location       = ['45.2912', '-122.4037']
  end
end
