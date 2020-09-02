class ServicePattern::Response
  attr_reader :errors, :result

  def initialize(errors: [], result: nil)
    @errors = errors
    @result = result
    @success = !errors || errors.empty?
  end

  def error_messages
    @error_messages ||= @errors.map(&:message)
  end

  def error_types
    @error_types ||= @errors.map(&:type).reject(&:blank?)
  end

  def success?
    @success
  end
end
