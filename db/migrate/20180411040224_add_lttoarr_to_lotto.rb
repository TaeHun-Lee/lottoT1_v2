class AddLttoarrToLotto < ActiveRecord::Migration[5.2]
  def change
    add_column :lottos, :lttoarr, :string
  end
end
