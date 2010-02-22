class CleaningItem < ActiveRecord::Base

  has_many :finished_cleans

  def self.decrease
    all = self.all
    all.each { |e|
      logger.info ("before_update: " + e.title + ", " + e.counter.to_s)
      e.update_attribute("counter", e.counter - 1)
      logger.info ("after_update: " + e.title + ", " + e.counter.to_s + ", " + Time.now.to_s)
      #logger.info ("update: " + e.title + ", " + e.counter.to_s + ", at: " + Time.now)
      #e.update_attribute("counter", e.counter + 1)
      #logger.info (e.title + e.counter.to_s)
    }
  end
  
end
