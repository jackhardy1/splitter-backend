class ItemsController < ApplicationController

  def index
    render json: Item.where(bill_id: params[:bill_id])
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(:params).require(:item).permit(:name, :price)
  end

end
