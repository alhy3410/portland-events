class UpdateMessages < ActiveRecord::Migration
  def change
    add_column :contacts, :selecttosend, :boolean, default: false
  end
end
