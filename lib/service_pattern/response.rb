class ServicePattern::Response
  attr_reader :errors, :result

  def initialize(args)
    @errors = args[:errors] || []
    @result = args[:result]

    if args.key?(:success)
      @success = args.fetch(:success)
    elsif args.key?(:errors) && @errors.any?
      @success = false
    elsif @result
      @success = true
    else
      raise "Couldn't figure out if it was a success"
    end
  end

  def success?
    @success
  end
end
