class AddImageToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :image, :string
  end
end
