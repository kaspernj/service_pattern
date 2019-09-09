module ServicePattern
  path = "#{File.dirname(__FILE__)}/service_pattern"

  autoload :FailedError, "#{path}/failed_error"
  autoload :Response, "#{path}/response"
  autoload :Service, "#{path}/service"
end
