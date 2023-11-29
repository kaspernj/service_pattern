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
          model_errors = ServicePattern::SimpleModelErrors.execute!(model: model)
        else
          model_errors = models.map(&:errors).map(&:full_messages).flatten
        end

        if model_errors.empty?
          puts "ServicePattern::ModelsSave: Save wasn't successful #{model.class.name} but couldn't find any errors?"
        end

        errors += model_errors

        raise ActiveRecord::Rollback if errors.any?
      end
    end

    fail! errors.uniq if errors.any?
    succeed!
  end
end
