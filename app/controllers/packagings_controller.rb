class PackagingsController < ApplicationController

  def index
    @packagings = Packaging.all
  end

  def show
    @packaging = Packaging.find(params[:id])
  end
end
