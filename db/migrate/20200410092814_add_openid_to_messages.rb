class AddOpenidToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :openid, :string
    add_index :messages, :openid
  end
end
