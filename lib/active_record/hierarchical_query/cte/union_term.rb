require 'active_record/hierarchical_query/cte/non_recursive_term'
require 'active_record/hierarchical_query/cte/recursive_term'

module ActiveRecord
  module HierarchicalQuery
    module CTE
      class UnionTerm
        # @param [ActiveRecord::HierarchicalQuery::CTE::QueryBuilder] builder
        def initialize(builder)
          @builder = builder
        end

        def bind_values
          non_recursive_term.bind_values + recursive_term.bind_values
        end

        def arel
          non_recursive_term.arel.union(:all, recursive_term.arel)
        end

        private
        def recursive_term
          @rt ||= RecursiveTerm.new(@builder)
        end

        def non_recursive_term
          @nrt ||= NonRecursiveTerm.new(@builder)
        end
      end
    end
  end
end