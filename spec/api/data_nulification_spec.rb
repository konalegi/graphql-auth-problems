

RSpec.describe 'top level errors' do
  subject(:result) { GraphqlApi::DummySchema.execute(query_string, {}).to_h }

  let(:query_string) do
    <<~GRAPHQL
      query {
        bananas {
          nodes {
            name
          }
          totalCount
        }
        orange {
          name
        }

        # shop {
        #   bananas {
        #     nodes {
        #       name
        #     }
        #     totalCount
        #   }
        # }
      }
    GRAPHQL
  end


  it 'shows' do
    puts JSON.pretty_generate(result)
  end
end