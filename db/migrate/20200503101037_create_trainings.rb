class CreateTrainings < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.date :date
      t.string :content
      t.float :time
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
