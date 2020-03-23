module GraphqlApi
  class ErrorMiddleware

    def call(_parent_type, _parent_object, _field_definition, _field_args, query_context)
      yield
    rescue StandardError => error
      report_error(error, query_context)
      GraphQL::ExecutionError.new(error.message)
    end

    def report_error(error, query_context)
      # puts('Error processing query!')
      # puts(error)
      # puts(error.backtrace.join("\n"))
    end
  end
end
