module ServicePattern
  path = "#{File.dirname(__FILE__)}/service_pattern"

  autoload :CantExecuteError, "#{path}/cant_execute_error"
  autoload :Response, "#{path}/response"
  autoload :Service, "#{path}/service"
end
