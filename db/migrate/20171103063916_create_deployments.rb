class CreateDeployments < ActiveRecord::Migration[5.1]
  def change
    create_table :deployments do |t|
      t.integer :BearID
      t.integer :PTT_ID
      t.decimal :capture_lat
      t.decimal :capture_long
      t.string :Sex
      t.string :Age_class
      t.string :Ear_applied

      t.timestamps
    end
  end
end
