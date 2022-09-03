module ServicePattern
  class InvalidResponseError < RuntimeError; end

  path = "#{File.dirname(__FILE__)}/service_pattern"

  autoload :FailError, "#{path}/fail_error"
  autoload :FailedError, "#{path}/failed_error"
  autoload :ModelsSave, "#{path}/models_save"
  autoload :Response, "#{path}/response"
  autoload :Service, "#{path}/service"
  autoload :SimpleModelErrors, "#{path}/simple_model_errors"
end
