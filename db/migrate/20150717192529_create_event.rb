class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventname
      t.string :eventperson
      t.date :eventdate
      t.string :eventlocation
      t.string :eventinfo

      t.timestamps
    end
  end
end
