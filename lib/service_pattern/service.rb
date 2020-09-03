class ServicePattern::Service
  # The same as execute but doesn't catch FailedError so they are passed on to the parent service call
  def self.chain(*args, &blk)
    service = new(*args, &blk)

    can_execute_response = service.can_execute?
    ServicePattern::Service.fail!(can_execute_response.errors) unless can_execute_response.success?

    service.execute
  end

  def self.call(*args, &blk)
    execute(*args, &blk)
  end

  def self.execute(*args, &blk)
    service = new(*args, &blk)

    can_execute_response = service.can_execute?
    return can_execute_response unless can_execute_response.success?

    service.execute
  rescue ServicePattern::FailedError => e
    ServicePattern::Response.new(errors: e.errors)
  end

  def self.execute!(*args, &blk)
    service = new(*args, &blk)
    can_execute_response = service.can_execute?
    ServicePattern::Service.fail!(can_execute_response.errors) unless can_execute_response.success?
    response = service.execute
    ServicePattern::Service.fail!(response.errors) unless response.success?
    response.result
  end

  def self.convert_errors(errors)
    errors = [errors] unless errors.is_a?(Array)
    errors.map do |error|
      error = ServicePattern::FailError.new(message: error) unless error.is_a?(ServicePattern::FailError)
      error
    end
  end

  def self.fail!(errors)
    errors = convert_errors(errors)
    error_messages = errors.map(&:message)

    error = ServicePattern::FailedError.new(error_messages.join(". "))
    error.errors = errors

    raise error
  end

  def can_execute?
    succeed!
  end

  def execute(*_args)
    raise NoMethodError, "You should implement the `execute` method on your service"
  end

  def fail!(errors, type: nil)
    errors = [ServicePattern::FailError.new(message: errors, type: type)] if type

    ServicePattern::Service.fail!(errors)
  end

  def succeed!(result = nil)
    ServicePattern::Response.new(result: result)
  end
end
