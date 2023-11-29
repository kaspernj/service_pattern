class ServicePattern::SimpleModelErrors < ServicePattern::Service
  attr_reader :additional_attributes, :errors, :model, :models_inspected

  def initialize(model:, additional_attributes: [])
    @additional_attributes = additional_attributes
    @model = model
    @errors = []
    @models_inspected = []
  end

  def perform
    inspect_model(model)
    succeed!(errors)
  end

  def inspect_model(model_to_inspect) # rubocop:disable Metrics/PerceivedComplexity
    return if models_inspected.include?(model_to_inspect)

    model_to_inspect.valid? if model_to_inspect.errors.empty? # Generates the errors on the model so we can detect them
    models_inspected << model_to_inspect

    model_to_inspect.errors.messages.each do |attribute_name, attribute_errors|
      if attribute_name == :base
        @errors += attribute_errors
      else
        association = model_to_inspect.association(attribute_name) if model_to_inspect._reflections[attribute_name.to_s]

        attribute_errors.each do |message|
          if association
            if association_has_error?(model_to_inspect, attribute_name, message)
              next
            elsif message == "is invalid"
              next
            end
          end

          errors << "#{model_to_inspect.class.human_attribute_name(attribute_name)} #{message}"
        end
      end
    end

    collect_errors_from_associations(model_to_inspect)
  end

private

  def association_has_error?(model, association_name, error_message)
    association = model.association(association_name)
    target = association.target
    errors = []

    if target.is_a?(ActiveRecord::Base)
      errors += association_errors_for_model(target)
    else
      target&.each do |sub_model|
        errors += association_errors_for_model(sub_model)
      end
    end

    errors.include?(error_message)
  end

  def association_errors_for_model(model)
    errors = []
    model._reflections.each_key do |association_name|
      target = model.association(association_name.to_sym).target

      if target.is_a?(ActiveRecord::Base)
        association_recursive_errors(target, errors) unless models_inspected.include?(target)
      else
        target&.each do |sub_model|
          association_recursive_errors(sub_model, errors) unless models_inspected.include?(target)
        end
      end
    end

    errors
  end

  def association_recursive_errors(model, errors)
    model.valid?

    model.errors.messages.each_value do |attribute_errors|
      attribute_errors.each do |message|
        errors << message
      end
    end

    model._reflections.each_key do |association_name|
      target = model.association(association_name.to_sym).target

      if target.is_a?(ActiveRecord::Base)
        association_recursive_errors(target, errors)
      else
        target&.each do |sub_model|
          association_recursive_errors(sub_model, errors)
        end
      end
    end

    errors
  end

  def collect_errors_from_associations(model_to_scan_reflections_on)
    model_to_scan_reflections_on._reflections.each_key do |association_name|
      target = model_to_scan_reflections_on.association(association_name.to_sym).target

      if target.is_a?(ActiveRecord::Base)
        inspect_model(target)
      else
        target&.each do |sub_model|
          inspect_model(sub_model)
        end
      end
    end
  end
end
