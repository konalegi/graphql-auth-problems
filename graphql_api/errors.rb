module GraphqlApi
  module Errors
    # GraphQL execution error
    class ExecutionError < ::GraphQL::ExecutionError
      def initialize(message, ast_node: nil, options: nil, extensions: nil)
        extensions ||= {code: 'GENERIC_ERROR'}
        super
      end
    end

    # GraphQL not found error
    class RecordNotFound < ExecutionError
      # TODO: deprecate and remove status_code
      def initialize(message = 'Record not found', options: {status_code: 404}, extensions: {code: 'RECORD_NOT_FOUND'})
        super
      end
    end

    # Error raised in case of unauthorized access
    class NotAuthorizedError < GraphQL::ExecutionError
      def initialize(message, ast_node: nil, options: nil, extensions: nil)
        extensions ||= {code: 'UNAUTHORIZED'}
        super
      end
    end
  end
end