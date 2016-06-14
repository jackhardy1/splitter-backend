class BillsController < ApplicationController

  def index
    render json: Bill.all
  end

end
