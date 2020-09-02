class ServicePattern::FailError
  attr_reader :message, :type

  def initialize(message:, type: nil)
    @message = message
    @type = type
  end
end
