

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
    expect(result).to eq(
      {
        "data"=>{
          "bananas"=>{
            "nodes"=>[
              {"name"=>"banana"},
              nil
            ],
            "totalCount"=>2
          },
          "orange"=>{"name"=>"orange"}
        },
        "errors"=>[
          {
            "message"=>"Not authorized (Banana)",
            "locations"=>[{"line"=>3, "column"=>5}],
            "path"=>["bananas", "nodes", 1],
            "extensions"=>{"code"=>"UNAUTHORIZED"}
          }
        ]
      }
    )
  end
end