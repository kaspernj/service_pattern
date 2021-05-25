class FailService < ServicePattern::Service
  def perform
    fail! "Test error"
  end
end
