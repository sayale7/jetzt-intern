class DecreaseCleaningItems < ActiveRecord::Base
  
  all_items = CleaningItem.all
  all_items.each do |item|
    item.update_attribute("counter", item.counter - 1)
    log = Log.new
    log.logtext = item.title
    log.save
  end
  
end