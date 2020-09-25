class StoreController < ApplicationController
  include ImpressionCounter

  before_action :set_counter, only: [:index]

  def index
    @products = Product.order(:title)
    @counter = session[:counter]
  end
end
