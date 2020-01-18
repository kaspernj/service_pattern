class FailService < ServicePattern::Service
  def execute
    fail! "Test error"
  end
end
