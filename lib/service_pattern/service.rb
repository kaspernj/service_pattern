class ServicePattern::Service
  # The same as execute but doesn't catch FailedError so they are passed on to the parent service call
  def self.chain(*args, **opts, &blk)
    service = new(*args, **opts, &blk)

    can_execute_response = service.can_execute?
    ServicePattern::Service.fail!(can_execute_response.errors) unless can_execute_response.success?

    service.perform
  end

  def self.call(*args, **opts, &blk)
    execute(*args, **opts, &blk)
  end

  def self.execute(*args, **opts, &blk)
    new(*args, **opts, &blk).execute
  end

  def self.execute!(*args, **opts, &blk)
    new(*args, **opts, &blk).execute!
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

  def self.arguments(*arguments)
    arguments.each do |argument_name|
      argument argument_name
    end
  end

  def self.argument(argument_name, **args)
    attr_accessor argument_name

    @arguments ||= {}
    @arguments[argument_name] ||= {}

    args.each do |key, value|
      if key == :default
        @arguments[argument_name][key] = value
      else
        raise ArgumentError, "Invalid argument: #{argument_name}"
      end
    end
  end

  def initialize(**args)
    arguments = self.class.instance_variable_get(:@arguments)
    arguments&.each do |argument_name, argument_options|
      next if args.key?(argument_name)

      if argument_options.key?(:default)
        __send__("#{argument_name}=", argument_options.fetch(:default))
      else
        raise ArgumentError, "missing keyword: #{argument_name}"
      end
    end

    args.each do |key, value|
      raise ArgumentError, "unknown keyword: #{key}" unless arguments&.key?(key)

      __send__("#{key}=", value)
    end
  end

  def can_execute?
    succeed!
  end

  def execute
    can_execute_response = can_execute?
    return can_execute_response unless can_execute_response.success?

    response = perform
    ServicePattern::Response.check_response!(self, response)
    response
  rescue ServicePattern::FailedError => e
    ServicePattern::Response.new(errors: e.errors)
  end

  def execute!
    can_execute_response = can_execute?
    ServicePattern::Service.fail!(can_execute_response.errors) unless can_execute_response.success?
    response = perform
    ServicePattern::Response.check_response!(self, response)
    ServicePattern::Service.fail!(response.errors) unless response.success?
    response.result
  end

  def perform(*_args)
    raise NoMethodError, "You should implement the `perform` method on your service"
  end

  def fail!(errors, type: nil)
    errors = [ServicePattern::FailError.new(message: errors, type: type)] if type

    ServicePattern::Service.fail!(errors)
  end

  def save_models_or_fail(*models, simple_model_errors: true)
    ServicePattern::ModelsSave.execute!(models: models, simple_model_errors: simple_model_errors)
  end

  def succeed!(result = nil)
    ServicePattern::Response.new(result: result)
  end
end
