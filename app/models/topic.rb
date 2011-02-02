class Topic < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :title, :presence => true
  validates :content, :presence => true
  
end
