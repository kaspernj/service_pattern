module ServicePattern
  path = "#{File.dirname(__FILE__)}/service_pattern"

  autoload :Service, "#{path}/service"
  autoload :ServiceResponse, "#{path}/service_response"
end
