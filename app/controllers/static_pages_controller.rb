class StaticPagesController < ApplicationController
  def about
  end

  def contact
    @users = User.all
  end

  def home
  end
end
