class MessageCopy < ActiveRecord::Base
  
  belongs_to :message
  belongs_to :recipient
  belongs_to :folder
  
  delegate   :author, :created_at, :subject, :body, :recipients, :to => :message
  
  scope_out  :deleted
  scope_out  :not_deleted, :conditions => ["deleted IS NULL OR deleted = ?", false]
  
end
