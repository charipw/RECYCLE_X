class ItemsController < ApplicationController
  # def index
  #   @items = Item.all
  # end

  # def show
  #   @item = Item.find(params[:id])
  # end

  def new
    @item = Item.new
  end

  def find
    @item = Item.find_by(barcode: params[:barcode])
    respond_to do |format|
      if @item.nil?
        # Load data from Open food fact API and create an item using the data from the API
        # If data does not exist in the API
        # Then
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

    # def create
    #   @item = Item.new
    #   @item.name = item_params[:name]
    #   @item.name = item_params[:bar_code]
    #   @item.name = item_params[:eco_score]
    #   @item.save
    #   item_params[:type].each do |type|
    #     @packaging = Packaging.find_by(type)
    #     @packaging = Packaging.find_by(type: 'Unknown') if @packaging.empty
    #     ItemPackaging.create(item: @item, packaging: @packaging)
    #   end
    # end
  # end

  # private

  # def item_params
  #   params.require(:item).permit(:name, :bar_code, :eco_score, :photo, :type)
  # end
end
