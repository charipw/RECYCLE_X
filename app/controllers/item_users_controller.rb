class ItemUsersController < ApplicationController
  before_action :set_item_users, only: [:show]
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

  def set_item_users
    @item_user = ItemUser.find(params[:id])
  end
end
