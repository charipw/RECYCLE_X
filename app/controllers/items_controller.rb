class ItemsController < ApplicationController

  
  def new
    @item = Item.new
  end
  
  def find
    @item = Item.find_by(barcode:params[:barcode])
    respond_to do |format|
      if @item.nil?
        ## Show the form for a new item
        @item = Item.new
        format.json # Follow the classic Rails flow and look for a create.json view
        format.html {render :show }
      else
        # Item here is from the database
        format.json  # Follow the classic Rails flow and look for a create.json view
        format.html {render :show }
      end
    end
   end

end
