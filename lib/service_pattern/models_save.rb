class ServicePattern::ModelsSave < ServicePattern::Service
  attr_reader :models, :simple_model_errors

  def initialize(models:, simple_model_errors: true)
    @models = models
    @simple_model_errors = simple_model_errors
  end

  def perform
    errors = []

    models.first.transaction do
      models.each do |model|
        next if model.save

        if simple_model_errors
          errors += ServicePattern::SimpleModelErrors.execute!(model: model)
        else
          errors += models.map(&:errors).map(&:full_messages).flatten
        end

        raise ActiveRecord::Rollback if errors.any?
      end
    end

    fail! errors.uniq if errors.any?
    succeed!
  end
end
