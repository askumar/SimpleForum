class AddCommentsCount < ActiveRecord::Migration
  def self.up
    add_column :topics, :comments_count, :integer, :default => 0

    Topic.reset_column_information
    Topic.all.each do |t|
      t.update_attribute :comments_count, t.comments.length
    end
  end

  def self.down
    remove_column :topics, :comments_count
  end
end
