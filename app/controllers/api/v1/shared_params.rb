module API
  module V1
    module SharedParams
      extend Grape::API::Helpers

      params :order do |options|
        optional :order_by, type: Symbol, values: options[:order_by], default: options[:default_order_by], desc: "Order by"
        optional :direction, type: Symbol, values: %i(asc desc), default: options[:default_order], desc: "Direction"
      end
  
      params :filter do |options|
        optional :filter_by, type: Symbol, values: options[:filter_by], default: options[:default_filter_by], desc: "Filter by"
        optional :filter_value, type: Symbol, values: options[:filter_value], desc: "Filter value"
      end

    end
  end
end