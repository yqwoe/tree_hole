class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.text :body_html

      t.timestamps
    end
  end
end
