class ServicePattern::RecursiveErrors
  def initialize(models:, models_inspected: [])
    @models = models
    @models_inspected = models_inspected
    @errors = []
  end

  def perform
    @models.each do |model|
      association_recursive_errors(model)
    end

    @errors
  end

  def association_recursive_errors(model)
    @models_inspected << model
    model.valid? # Generate validation errors on model

    model.errors.messages.each_value do |attribute_errors|
      attribute_errors.each do |message|
        @errors << message
      end
    end

    model._reflections.each_key do |association_name|
      target = model.association(association_name.to_sym).target

      if target.is_a?(ActiveRecord::Base)
        association_recursive_errors(target) unless @models_inspected.include?(target)
      else
        target&.each do |sub_model|
          association_recursive_errors(sub_model) unless @models_inspected.include?(sub_model)
        end
      end
    end
  end
end
