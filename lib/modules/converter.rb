module Converter

  def tesseract
    system("convert #{Bill.last.image.url} -resize 6000 receipt.jpg")
    system("convert receipt.jpg -type Grayscale receipt.jpg")
    system("tesseract receipt.jpg output")
    find_total
    create_items
    system("rm output.txt")
    system("rm receipt.jpg")
  end

  private

  def find_total
   a = File.readlines('./output.txt').grep(/TOTAL/)
   b = a.map {|x| x[/\d+(?:[.,]\d+)?/].to_f}[0]
   Bill.last.update(total:"#{b}")
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
    quantity_exists?(line) ? line.scan(/(\d+)/).flatten[0].to_i : 1
  end

  def search_for_words(line)
    line.split(" ").select{|word|word.match(/([a-z])/)}.join(" ")
  end

  def quantity_exists?(line)
    line.scan(/(\d+)/).flatten[0].to_i
  end
end
