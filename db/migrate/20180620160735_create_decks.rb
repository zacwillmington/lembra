class CreateDecks < ActiveRecord::Migration
  def change
      create_table :decks do |t|
          t.string :title
          t.string :category
          t.integer :user_id
          t.integer :number_of_cards
      end
  end
end
