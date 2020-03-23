
module GraphqlApi
  module Types
    class Banana
      attr_reader :name

      def initialize(name, ctx)
        @name = name
      end
    end

    class OrangeType < BaseType
      field :name, String, null: false

      def name
        'orange'
      end

      def self.authorized?(obj, context)
        # obj.name == 'banana1' ? true : false
        false
      end
    end

    class BananaType < BaseType
      field :name, String, null: false

      def name
        'banana'
      end

      def self.authorized?(obj, context)
        # obj.name == 'banana1' ? true : false
        true
      end
    end

    class ShopType < BaseType
      field :bananas, Connection.offset(BananaType, graphql_name: 'ShopBananas'), null: false

      def bananas
        BananasResolver.new
      end
    end

    class BananasResolver
      def initialize(context)
        @context = context
      end

      def nodes
        items
      end

      def total_count
        items.count
      end

      def items
        [
          Banana.new('banana1', @context),
          Banana.new('banana2', @context)
        ]
      end
    end

    class QueryType < BaseType

      def object; {}; end

      field :orange, OrangeType, null: false
      field :bananas, Connection.offset(BananaType), null: false
      field :shop, ShopType, null: false

      def bananas
        BananasResolver.new(context)
      end

      def shop
        [Object.new]
      end

      def orange
        Object.new
      end
    end
  end
end