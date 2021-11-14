class ServicePattern::Response
  attr_reader :errors, :result

  def initialize(errors: [], result: nil)
    @errors = ServicePattern::Service.convert_errors(errors)
    @result = result
    @success = !errors || errors.empty?
  end

  def error_messages
    @error_messages ||= @errors.map(&:message)
  end

  def error_types
    @error_types ||= @errors.map(&:type).reject(&:blank?)
  end

  def error_type?(type)
    error_types.include?(type)
  end

  def only_error_type?(type)
    error_types.length == 1 && error_type?(type)
  end

  def raise_error!
    error = ServicePattern::FailedError.new(error_messages.join(". "))
    error.errors = errors

    raise error
  end

  def success?
    @success
  end
end
