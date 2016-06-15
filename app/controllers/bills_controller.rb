class BillsController < ApplicationController

  def index
    render json: Bill.all
  end

  def create
    Bill.create(bill_params)
  end

  def show
    render json: Bill.find(params[:id])
  end

  private

  def bill_params
    params.require(:params).require(:bill).permit(:event)
  end


end
