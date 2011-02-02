class AddCommentsCount2 < ActiveRecord::Migration
  def self.up
    add_column :comments, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :comments, :comments_count
  end
end
