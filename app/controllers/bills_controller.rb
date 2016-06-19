require './lib/modules/converter.rb'
class BillsController < ApplicationController
  include Converter

  def index
    render json: Bill.all
  end

  def create
    Bill.create(bill_params)
    tesseract
  end

  def show
    render json: Bill.find(params[:id])
  end

  def update
    current_bill = Bill.find(params[:id])
    current_bill.update(bill_params)
  end

  private

  def bill_params
    image = convert_image
    params.permit(:event, :image).merge(image: image)
  end

  def convert_image
    Paperclip.io_adapters.for(params[:image])
  end
end
