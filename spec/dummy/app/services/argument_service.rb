class ArgumentService < ServicePattern::Service
  arguments :required_argument
  argument :optional_argument, default: "Kasper"

  def perform
    return ChainedFailingService.chain if chained_failing_service

    fail! "should fail on execute" if should_fail_on_execute
    succeed!
  end
end
