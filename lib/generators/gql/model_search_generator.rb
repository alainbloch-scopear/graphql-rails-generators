require_relative 'gql_generator_base'
module Gql
  class ModelSearchGenerator < Rails::Generators::Base
    include GqlGeneratorBase
    source_root File.expand_path('../templates', __FILE__)
    argument :model_name, type: :string
    class_option :directory, type: :string, default: 'graphql'

    def search
      inject_into_file(
        "app/#{options[:directory]}/types/query_type.rb",
        "\t\tfield :#{model_name.downcase.pluralize}, resolver: Resolvers::#{model_name}Search \n", 
        :after => "class QueryType < Types::BaseObject\n"
      )
      file_name = "#{model_name.underscore}_search"
      @fields = map_model_types(model_name)
      template('model_search.rb', "app/#{options[:directory]}/resolvers/#{file_name}.rb")
    end
  end
end