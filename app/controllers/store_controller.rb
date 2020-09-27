class StoreController < ApplicationController
  include ImpressionCounter
  include CurrentCart

  before_action :set_counter, only: [:index]
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @counter = session[:counter]
  end
end
