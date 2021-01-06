class ChangeFollowsToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_table :relations, :relationships
  end
end
