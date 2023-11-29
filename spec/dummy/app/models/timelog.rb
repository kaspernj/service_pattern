class Timelog < ApplicationRecord
  belongs_to :task

  validates :description, presence: true

  validate :validate_task_name

private

  def validate_task_name
    errors.add(:task, "has an invalid name") if task&.name == "INVALID TASK NAME"
  end
end
