require './lib/modules/converter.rb'
class BillsController < ApplicationController
  include Converter

  def index
    render json: Bill.all
  end

  def create
    Bill.create(bill_params)
    p 'Bill created'
    tesseract
    p 'Tesseract completed'
  end

  def show
    render json: Bill.find(params[:id])
  end

  private

  def bill_params
    image = convert_image
    params.permit(:event).merge(image: image)
  end

  def convert_image
    Paperclip.io_adapters.for(params[:image])
  end
end
