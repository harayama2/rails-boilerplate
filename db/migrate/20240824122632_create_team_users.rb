class CreateTeamUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_users do |t|
      t.belongs_to :team, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :role, null: false

      t.timestamps
    end
  end
end
