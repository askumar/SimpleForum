class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  has_many :replies, :as => :commentable, :dependent => :destroy, :class_name => 'Comment'
                                                                                                                                             
  validates_associated :commentable
  validates :content, :presence => true
            
  after_save :update_commentable_root
  after_create :increase_comments_count
  after_destroy :decrease_comments_count

  def commentable_root
    commentable_root = self.commentable
    commentable_root = commentable_root.commentable while commentable_root.is_a? Comment
    commentable_root
  end

  protected

  def update_commentable_root
    commentable_root.update_attribute :updated_at, updated_at
  end

  def increase_comments_count
    Topic.increment_counter(:comments_count, commentable_root.id) if commentable.is_a? Comment
  end

  def decrease_comments_count
    Topic.decrement_counter(:comments_count, commentable_root.id) if commentable.is_a? Comment
  end
  
end
