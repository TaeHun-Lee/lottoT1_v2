class AddLttorandarrToLotto < ActiveRecord::Migration[5.2]
  def change
    add_column :lottos, :lttorandarr, :string
  end
end
