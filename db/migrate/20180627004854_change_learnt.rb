class ChangeLearnt < ActiveRecord::Migration
  def change
      change_column :cards, :learnt, :string 
  end
end
