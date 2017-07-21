class ServicePattern::Service
  def self.call(*args)
    service = new(*args)

    begin
      can_execute_response = service.can_execute?
      return can_execute_response unless can_execute_response.success?
      service.execute!
    rescue => e
      ServicePattern::Response.new(errors: ["#{e.class.name}: #{e.message}"], success: false)
    end
  end

  def self.execute!(*args)
    service = new(*args)

    can_execute_response = service.can_execute?
    raise ServicePattern::CantExecuteError, can_execute_response.errors.join(". ") unless can_execute_response.success?
    service.execute!
  end

  def can_execute?
    ServicePattern::Response.new(success: true)
  end

  def execute!(*_args)
    raise NoMethodError, "You should implement the `execute!` method on your service"
  end
end
