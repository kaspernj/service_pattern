module ServicePattern
  class InvalidResponseError < RuntimeError; end

  path = "#{File.dirname(__FILE__)}/service_pattern"

  autoload :FailError, "#{path}/fail_error"
  autoload :FailedError, "#{path}/failed_error"
  autoload :Response, "#{path}/response"
  autoload :Service, "#{path}/service"
end
