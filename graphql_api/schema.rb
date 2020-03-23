module GraphqlApi
  class DummySchema < GraphQL::Schema
    query ::GraphqlApi::Types::QueryType
    middleware ::GraphqlApi::ErrorMiddleware.new
    max_depth 15
    max_complexity 200
    use GraphQL::Execution::Interpreter
    use GraphQL::Analysis::AST

    def self.resolve_type(_type, obj, _ctx)
      binding.pry
      name = obj.class.name
      type_class = types[name] || types[TYPES_MAPPING[name]]
      raise("Cannot find valid Type object for: #{obj}") unless type_class

      type_class
    end

    def self.unauthorized_object(error)
      raise GraphqlApi::Errors::NotAuthorizedError, "Not authorized (#{error.type.graphql_name})"
    end

    def self.unauthorized_field(error)
      raise GraphqlApi::Errors::NotAuthorizedError, "Not authorized (#{error.type.graphql_name}.#{error.field.graphql_name})"
    end
  end
end

GraphqlApi::DummySchema.graphql_definition
