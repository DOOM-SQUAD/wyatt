require 'rails'

class Railtie < Rails::Railtie
  def self.generator
    config.respond_to?(:app_generators) ? :app_generators : :generators
  end

  rake_tasks do
    load "nss/rails_tasks.rb"
  end

  config.wyatt = ::Wyatt::Configuration
  config_file  = Rails.root.join('config', 'nss.yml')

  initializer "wyatt.load-config" do
    if config_file.file?
      Wyatt.load!(config_file)
    end
  end

  config.after_initialize do
    unless config_file.file? || ::Wyatt.configured?
      puts "Wyatt could not find a configuration file. Please create it at: config/wyatt.yml"
    end
  end
end
