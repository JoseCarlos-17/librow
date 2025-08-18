class AddGenresToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :genres, :text, array: true, default: []
  end
end
