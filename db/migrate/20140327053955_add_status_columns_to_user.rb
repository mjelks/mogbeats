class AddStatusColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mog_process, :boolean, :default => false
    add_column :users, :mog_process_status, :string
  end
end
