class AddColumnCards < ActiveRecord::Migration
  def change
      add_column(:cards, :flip, :boolean)
  end
end
