class ServicePattern::Response
  attr_reader :errors, :result

  def initialize(errors: [], result: nil)
    @errors = errors
    @result = result
    @success = !errors || errors.empty?
  end

  def success?
    @success
  end
end
