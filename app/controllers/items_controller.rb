class ItemsController < ApplicationController

  def index
    render json: Item.where(bill_id: params[:bill_id])
  end

end
