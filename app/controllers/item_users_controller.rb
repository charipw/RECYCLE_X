class ItemUsersController < ApplicationController
  before_action :set_item_user, only: [:show]
  def barcode
  end

  def index
    # @useritems = ItemUser.where(user: current_user)
    @useritems = ItemUser.select("DISTINCT ON(item_id) item_users.*").where(user: current_user)
    # items = @useritems.pluck(:item).uniq
    # @useritems = []
    # items.each do |item|
    #   @useritems << ItemUser.find_by(item:)
    # end
    # @items = Item.all
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
