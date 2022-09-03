class CreateTimelogs < ActiveRecord::Migration[7.0]
  def change
    create_table :timelogs do |t|
      t.references :task, foreign_key: true, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
