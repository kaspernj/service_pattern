class ServicePattern::FailedError < RuntimeError
  attr_accessor :errors

  def error_messages
    @error_messages ||= @errors.map(&:message)
  end

  def error_types
    @error_types ||= @errors.map(&:type)
  end
end
