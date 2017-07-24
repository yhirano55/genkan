module Genkan
  class Engine < ::Rails::Engine
    isolate_namespace Genkan

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
