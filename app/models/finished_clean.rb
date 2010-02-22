class FinishedClean < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cleaning_item
  
  validates_presence_of :user_id
  
end
