class AddLttogetarrToLotto < ActiveRecord::Migration[5.2]
  def change
    add_column :lottos, :lttogetarr, :string
  end
end
