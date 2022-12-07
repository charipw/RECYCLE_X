class ItemUsersController < ApplicationController
  def barcode
  end

  def index
    @useritems = ItemUser.select("DISTINCT ON(item_id) item_users.*").where(user: current_user)
    @user = current_user
  end

  def show
    @user = current_user
    @item_user = ItemUser.find(params[:id])
    @item = Item.find(@item_user.item_id)
    @recycled_packagings = []
    @non_recycled_packagings = []
    @item.packagings.each do |packaging|
      packaging.rules.each do |rule|
        if rule.borough_id == @user.borough_id
          if rule.is_recycled == true
            @recycled_packagings << packaging
          else
            @non_recycled_packagings << packaging
          end
        end
      end
    end
  end
end
