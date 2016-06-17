class Bill < ActiveRecord::Base

  attr_accessor :content_type, :original_filename, :image_data
   before_save :decode_base64_image
   has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

   def tesseract
     %x`convert #{Bill.last.image.url} -resize 6000 fake-receipt.jpg`
     %x`convert fake-receipt.jpg -type Grayscale fake-receipt.jpg`
     %x`tesseract fake-receipt.jpg output`
     find_total
     create_items
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
          Item.create(name: search_for_words(line), price: search_for_float(line))
        end
      end
    end
  end

  def search_for_float(line)
    line.scan(/(\d+[,.]\d+)/).flatten[0].to_f
  end

  def search_for_words(line)
    line.split(" ").select{|word|word.match(/([a-z])/)}.join(" ")
  end

 protected

 def decode_base64_image
   if image_data && content_type && original_filename
     decoded_data = Base64.decode64(image_data)

     data = StringIO.new(decoded_data)
     data.class_eval do
       attr_accessor :content_type, :original_filename
     end

     data.content_type = content_type
     data.original_filename = File.basename(original_filename)

     self.image = data
   end
 end

 has_many :items

end
