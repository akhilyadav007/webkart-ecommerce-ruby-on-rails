class AddDeatilToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :name, :string
    add_column :customers, :address, :string
    add_column :customers, :contact, :integer
    add_column :customers, :is_admin, :boolean
  end
end
