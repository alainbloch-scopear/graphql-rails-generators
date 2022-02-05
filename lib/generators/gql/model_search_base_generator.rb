module Gql
  class ModelSearchBaseGenerator < Rails::Generators::Base          
    source_root File.expand_path('../templates', __FILE__)
    class_option :directory, type: :string, default: 'graphql'

    def generate_model_search_base
      gem 'search_object_graphql'    
      template('model_search_base.rb', "app/#{directory}/resolvers/base_search_resolver.rb")
    end
  end
end