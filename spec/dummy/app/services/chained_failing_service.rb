class ChainedFailingService < ServicePattern::Service
  def execute
    raise ServicePattern::FailedError, "Chained fail"
  end
end
