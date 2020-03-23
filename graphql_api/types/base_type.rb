
module GraphqlApi
  module Types
    class BaseField < GraphQL::Schema::Field
      def connection?
        return @connection if defined?(@connection) && !@connection.nil?

        false
      end
    end

    class BaseType < GraphQL::Schema::Object
      field_class BaseField
    end

    class Connection
      class Offset < BaseType; end

      def self.offset(type_class, graphql_name: nil)
        class_name = graphql_class_name(type_class, graphql_name)

        Class.new(Offset) do
          graphql_name class_name

          field :nodes, [type_class], null: false
          field :total_count, Integer, null: false
        end
      end

      def self.graphql_class_name(type_class, graphql_name)
        return graphql_name unless graphql_name.nil?

        "#{type_class.graphql_name}Connection"
      end
    end
  end
end