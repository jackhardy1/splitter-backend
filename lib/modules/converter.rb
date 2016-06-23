module Converter

  def tesseract
    system("convert #{Bill.last.image.url} -fill black -draw 'color 5,5 floodfill' -negate -resize 120% receipt.jpg")
    system("tesseract receipt.jpg output")
    create_items
    system("rm output.txt")
    system("rm receipt.jpg")
  end
  
  def create_items
   File.open './output.txt', 'r' do |file|
     file.each_line do |line|
       if search_for_words(line).length != 0
         Item.create(
         name: search_for_words(line),
         price: search_for_float(line),
         quantity: search_for_integer(line),
         bill_id: Bill.last.id
         )
       end
     end
   end
  end

  def search_for_float(line)
    line.gsub!(',','.')
    line.scan(/(\d+[,.]\d+)/).flatten[0].to_f
  end

  def search_for_integer(line)
    line.gsub!(',','.')
    line.scan(/(\d+)/).flatten[0].to_i
  end

  def search_for_words(line)
    line.split(" ").select{|word|word.match(/([a-zA-Z])/)}.join(" ").capitalize
  end

end
