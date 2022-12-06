class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @url = request.original_url
  end

  def resources
  end
end
