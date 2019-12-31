class ServicePattern::FailedError < RuntimeError
  attr_accessor :errors
end
