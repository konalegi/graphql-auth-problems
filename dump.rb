PROJECT_ROOT = File.expand_path('.', __dir__)
$LOAD_PATH << PROJECT_ROOT

require 'app'


File.write('schema.graphql', GraphqlApi::DummySchema.to_definition)
