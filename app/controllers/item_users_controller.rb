class ItemUsersController < ApplicationController
  before_action :set_item_user, only: [:show]
  def barcode
  end

  def index
    @useritems = ItemUser.all
    @items = Item.all
    @user = current_user
  end

  def show
    @user = current_user
  end

  private

  def set_item_user
    @item_user = ItemUser.find(params[:id])
    @item = Item.find(@item_user.item_id)
  end
end
