module Exceptions
  class Error < StandardError; end
  class NonRemovableValueError < Error; end
end
