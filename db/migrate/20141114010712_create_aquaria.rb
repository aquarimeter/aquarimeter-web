class CreateAquaria < ActiveRecord::Migration
  def change
    create_table :aquaria do |t|

      t.timestamps
    end
  end
end
