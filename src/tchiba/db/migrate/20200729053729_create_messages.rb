class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.boolean :is_from_user, default: true
      t.text :content
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
