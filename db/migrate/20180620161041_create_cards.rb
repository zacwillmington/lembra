class CreateCards < ActiveRecord::Migration
  def change
      create_table :cards do |t|
          t.string :front_side
          t.string :back_side
          t.integer :deck_id
          t.boolean :learnt
      end
  end
end
