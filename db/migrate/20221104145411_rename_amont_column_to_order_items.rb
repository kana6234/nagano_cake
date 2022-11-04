class RenameAmontColumnToOrderItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_items, :amont, :amount
  end
end
