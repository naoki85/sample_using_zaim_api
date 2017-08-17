class PagesController < ApplicationController
  skip_before_action :authenticate

  def top
  end
end