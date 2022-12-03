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
    @user = current_user
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
        # format.json  # Follow the classic Rails flow and look for a create.json view
        # format.html {render :show }
        @item_user = ItemUser.new
        @item_user.user = current_user
        @item_user.item = @item
        @item_user.save
        format.json
        render json: @item_user
      end
    end
  end

  def create
    @item = Item.new
    @item.name = item_params[:name]
    @item.barcode = item_params[:barcode]
    @item.eco_score = item_params[:eco_score]
    @item.save
    @item_user = ItemUser.new
    @item_user.user = current_user
    @item_user.item = @item
    @item_user.save
    redirect_to product_path(@item_user.id)
    # item_params[:type].each do |type|
    #   @packaging = Packaging.find_by(type)
    #   @packaging = Packaging.find_by(type: 'Unknown') if @packaging.empty
    #   ItemPackaging.create(item: @item, packaging: @packaging)
    # end
  end

  private

  def item_params
    params.require(:item).permit(:name, :barcode, :eco_score, :photo, :type)
  end


end
