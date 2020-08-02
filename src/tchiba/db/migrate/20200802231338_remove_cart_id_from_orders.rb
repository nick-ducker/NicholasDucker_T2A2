class RemoveCartIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orders, :cart, null: false, foreign_key: true
  end
end
