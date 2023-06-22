class CreateExcavators < ActiveRecord::Migration[7.0]
  def change
    create_table :excavators do |t|
      t.string :company_name
      t.string :address
      t.boolean :crew_onsite

      t.belongs_to :ticket

      t.timestamps
    end
  end
end
