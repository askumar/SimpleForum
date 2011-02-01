class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :replies, :as => :commentable, :dependent => :destroy, :class_name => 'Comment'
                                                                                                                                             
  validates_associated :commentable
  validates :content, :presence => true
            
  after_save :update_commentable_root

  def commentable_root
    commentable_root = self.commentable
    commentable_root = commentable_root.commentable while commentable_root.is_a? Comment
    commentable_root
  end

  protected

  def update_commentable_root
    commentable_root.update_attribute :updated_at, updated_at
  end
  
end
