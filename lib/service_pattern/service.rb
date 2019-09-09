class ServicePattern::Service
  def self.call(*args)
    new(*args).execute
  end

  def self.execute(*args, &blk)
    service = new(*args, &blk)

    can_execute_response = service.can_execute?
    return can_execute_response unless can_execute_response.success?

    service.execute
  end

  def self.execute!(*args, &blk)
    response = execute(*args, &blk)
    raise ServicePattern::FailedError, response.errors.join(". ") unless response.success?

    response.result
  end

  def can_execute?
    ServicePattern::Response.new(success: true)
  end

  def execute(*_args)
    raise NoMethodError, "You should implement the `execute!` method on your service"
  end
end
