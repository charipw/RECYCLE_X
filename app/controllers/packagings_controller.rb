class PackagingsController < ApplicationController

  def index
    if params[:query].present?
      @packagings = Packaging.search_by_category_and_type(params[:query])
    else
      @packagings = Packaging.all
    end
  end

  def show
    @packaging = Packaging.find(params[:id])
  end
end
