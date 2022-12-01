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
  end

  private

  def set_item_user
    @item = ItemUser.find(params[:id])
  end
end
