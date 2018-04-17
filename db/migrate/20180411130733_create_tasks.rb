class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name ,null:false
      t.integer :list_id ,null:false
      t.timestamps
    end
  end
end
