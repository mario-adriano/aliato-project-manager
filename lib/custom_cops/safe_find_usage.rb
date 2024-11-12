require_relative "../../config/environment" unless defined?(Rails)

module RuboCop
  module Cop
    module Custom
      class SafeFindUsage < RuboCop::Cop::Base
        MSG = "Avoid using `find` on ActiveRecord models without exception handling. Wrap it in `begin...rescue` to catch `ActiveRecord::RecordNotFound`."

        def on_send(node)
          return unless node.method_name == :find

          receiver = node.receiver
          return unless active_record_model?(receiver)

          return if rescue_from_record_not_found_configured?(node)

          unless within_rescue_context?(node)
            add_offense(node, message: MSG)
          end
        end

        private

        def active_record_model?(receiver)
          return false unless receiver&.const_type?

          klass = safe_const_get(receiver.const_name)
          klass && klass < ActiveRecord::Base
        end

        def safe_const_get(name)
          Object.const_get(name)
        rescue NameError
          nil
        end

        def within_rescue_context?(node)
          method_node = node.each_ancestor(:def).first
          return false unless method_node

          contains_rescue?(method_node.body)
        end

        def contains_rescue?(node)
          return false unless node
          if node.kwbegin_type?
            node.children.any?(&:rescue_type?)
          elsif node.rescue_type?
            true
          else
            node.children.any? { |child| contains_rescue?(child) if child.is_a?(Parser::AST::Node) }
          end
        end

        def rescue_from_record_not_found_configured?(node)
          exceptions = %w[ActiveRecord::RecordNotFound ActiveRecord::ActiveRecordError StandardError]

          controller_node = node.each_ancestor(:class).find do |ancestor|
            ancestor.descendants.any? do |child|
              child.send_type? &&
                child.method_name == :rescue_from &&
                exceptions.include?(child.arguments.first.source)
            end
          end

          !!controller_node
        end
      end
    end
  end
end
