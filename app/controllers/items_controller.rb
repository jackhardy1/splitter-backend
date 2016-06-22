class ItemsController < ApplicationController

  def index
    render json: Item.where(bill_id: params[:bill_id])
  end

  def create
    Item.create(item_params)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  def show
    render json: Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
  end

  private

  def item_params
    bill = params.require(:bill_id)
    params.require(:item).permit(:name, :price, :quantity, :contact).merge(bill_id: bill)
  end

end
