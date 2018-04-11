class CreateLottos < ActiveRecord::Migration[5.2]
  def change
    create_table :lottos do |t|
        t.string :lotton
        t.string :choice
        t.integer :lbonum
      t.timestamps
    end
  end
end
