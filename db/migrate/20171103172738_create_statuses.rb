class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.references :deployment, foreign_key: true
      t.integer :deployID
      t.string :recieved
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :temperature

      t.timestamps
    end
  end
end
