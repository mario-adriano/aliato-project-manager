# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module Custom
      class FindByNilCheck < RuboCop::Cop::Base
        MSG = <<~MSG.strip
          Always check for nil or use appropriate verification when using the object returned by find_by.
          Examples of incorrect usage:

          # Offense: Using `find_by` without nil check, which can raise an error if the result is nil.
          user = User.find_by(email: 'user@example.com')
          user.update(last_login: Time.current) # Potential error if `user` is nil.

          # Offense: Calling a method directly on the object returned by `find_by` without checking for nil.
          post = Post.find_by(title: 'Ruby Tips')
          post.comments.count # Potential error if `post` is nil.
        MSG


        SAFE_METHODS = %i[present? blank? nil? any? empty? inspect class try]

        def on_lvasgn(node)
          variable_name = node.children.first
          value = node.children[1]
          return unless value&.send_type? && value.method_name == :find_by

          scope = node.parent
          usages = find_variable_usages(scope, variable_name, node)

          usages.each do |usage|
            next if safe_usage?(usage)
            next if safe_condition?(usage, variable_name)
            add_offense(usage, message: MSG)
          end
        end

        def on_send(node)
          if node.method_name == :find_by && node.parent&.send_type?
            next_method = node.parent
            return if next_method.method_name == :try

            add_offense(next_method, message: MSG)
          end
        end

        private

        def find_variable_usages(scope, variable_name, assignment_node)
          usages = []
          variable_reassigned = false

          scope.each_node do |node|
            if node == assignment_node
              variable_reassigned = false
            elsif node.lvasgn_type? && node.children.first == variable_name
              variable_reassigned = true unless node == assignment_node
            end

            next if variable_reassigned

            if variable_used_in_method_call?(node, variable_name)
              usages << node
            end
          end

          usages
        end

        def variable_used_in_method_call?(node, variable_name)
          node.send_type? &&
            node.receiver &&
            node.receiver.lvar_type? &&
            node.receiver.children.first == variable_name &&
            !SAFE_METHODS.include?(node.method_name) &&
            !node_in_condition?(node)
        end

        def node_in_condition?(node)
          node.each_ancestor(:if, :unless).any? do |ancestor|
            ancestor.condition == node
          end
        end

        def safe_usage?(node)
          node.csend_type? ||
            (node.send_type? && SAFE_METHODS.include?(node.method_name))
        end

        def safe_condition?(node, variable_name)
          node.each_ancestor(:if, :unless) do |ancestor|
            condition = ancestor.condition

            if variable_guaranteed_not_nil_in_branch?(ancestor, condition, variable_name, node)
              return true
            elsif variable_is_nil_in_condition?(ancestor, condition, variable_name, node)
              return false
            end
          end
          false
        end

        def variable_guaranteed_not_nil_in_branch?(ancestor, condition, variable_name, node)
          branch = if ancestor.if?
                     if variable_not_nil_condition?(condition, variable_name)
                       ancestor.if_branch
                     elsif variable_is_nil_condition?(condition, variable_name)
                       ancestor.else_branch
                     end
          elsif ancestor.unless?
                     if variable_is_nil_condition?(condition, variable_name)
                       ancestor.if_branch
                     elsif variable_not_nil_condition?(condition, variable_name)
                       ancestor.else_branch
                     end
          end

          branch ? inside_branch?(node, branch) : false
        end

        def variable_is_nil_in_condition?(ancestor, condition, variable_name, node)
          (ancestor.if? && variable_is_nil_condition?(condition, variable_name)) ||
            (ancestor.unless? && variable_not_nil_condition?(condition, variable_name))
        end

        def variable_not_nil_condition?(condition, variable_name)
          (condition.lvar_type? && condition.children.first == variable_name) ||
            (condition.send_type? &&
             condition.receiver&.lvar_type? &&
             condition.receiver.children.first == variable_name &&
             %i[present?].include?(condition.method_name))
        end

        def variable_is_nil_condition?(condition, variable_name)
          condition.send_type? &&
            condition.receiver&.lvar_type? &&
            condition.receiver.children.first == variable_name &&
            %i[nil? blank?].include?(condition.method_name)
        end

        def inside_branch?(node, branch)
          return false unless branch

          branch.each_node.any? { |n| n == node || n.descendants.include?(node) }
        end
      end
    end
  end
end
