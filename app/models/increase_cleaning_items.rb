class IncreaseCleaningItems < ActiveRecord::Base
  
  all_items = CleaningItem.all
  for item in all_items
    item.update_attribute("counter", item.counter + 1)
  end
  
end