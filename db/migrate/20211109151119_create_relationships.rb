class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :following, foreign_key: { to_table: :users }
      t.references :follower, foreign_key: { to_table: :users }

      t.timestamps

      t.index [:following_id, :follower_id], unique: true

    end
  end
end
