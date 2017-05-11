class ServicePattern::Service
  def self.call(*args)
    service = new(*args)

    begin
      return service.execute!
    rescue => e
      ServicePattern::ServiceResponse.new(errors: ["#{e.class.name}: #{e.message}"], success: false)
    end
  end

  def self.execute!(*args)
    new(*args).execute!
  end

  def execute!(*_args)
    raise NoMethodError, "You should implement the `execute!` method on your service"
  end
end
