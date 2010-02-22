class FinishedCleansController < ApplicationController
  
  def create
    @finished_clean = FinishedClean.new(params[:finished_clean])
    @cleaning_item = CleaningItem.find(@finished_clean.cleaning_item_id)
    if @finished_clean.user_id.nil?
      flash[:error] = "Bitte einen User auswählen!"
      redirect_to cleaning_item_path(@cleaning_item)
    else
      @cleaning_item.update_attribute("counter", @cleaning_item.intervall)
      @finished_clean.save!
      redirect_to cleaning_item_path(@cleaning_item)
    end
  end
  
  
end
