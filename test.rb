require 'openfoodfacts'

#products = Openfoodfacts::Product.search("Chips", locale: 'world', page_size: 10)

#test_ids = []
#products.each do |product|
  #test_ids << product._id
#end


#code = "0000000005" #barcode
#product = Openfoodfacts::Product.get(code, locale: 'fr')
#p product.packaging_hierarchy
#p product.packaging_tags
#p product.packaging_old
#p product.packagings

#Nutella
#code = "3017620422003"
#product = Openfoodfacts::Product.get(code, locale: 'world')
#p product.packaging_hierarchy
#p product.packaging_tags
#p product.packaging_old
#p product.packagings


#code = "000000000936"
#product = Openfoodfacts::Product.get(code, locale: 'world')
#p product.packaging_hierarchy
#p product.packaging_tags
#p product.packaging_old
#p product.packagings


#product = Openfoodfacts::Product.search("Chocolate", locale: 'world', page_size: 10)
#product.each do |pr|
#p pr.product_name
#p pr.packaging_hierarchy
#p pr.packaging_tags
#p pr.packaging_old
#p pr.packagings
#p pr.packaging
#p pr.packaging_lc
#end

#packaging="Verre" packaging_hierarchy=#<Hashie::Array ["en:glass"]> packaging_lc="fr" packaging_old="fr:verre" packaging_old_before_taxonomization="verre" packaging_tags=#<Hashie::Array ["en:glass"]> packagings=#<Hashie::Array [#<Openfoodfacts::Product material="en:glass">]


#testids.each do |id|
  #product = Openfoodfacts::Product.get(id, locale: 'en')
  #p product.product_name
  #p product.product_packaging
  #p product.nutriments.to_hash
#end

packaging = Openfoodfacts::Packaging.all
results = []
intermediate = []
rest = []

packaging.each do |pa|
  if pa.name.match(/^[a-zA-Z]+(-)*[a-zA-Z]+(-)*[a-zA-Z]*(-)*[a-zA-Z]*(-)*[a-zA-Z]*$/)
    intermediate << pa.name
  end
end
intermediate.each do |element|
  if  element.to_s.length == 2
    rest << element
  elsif element.match(/[aeiou]/)
    results << element
  else
    rest << element
  end
end

results.each do |res|
  p res
end




p "intermediate: #{intermediate.count}"
p "rest: #{rest.count}"
p "results: #{results.count}"

#packaging.each do |pa|
  #if pa.name.match(/"\[a-zA-Z]+(-)*[a-zA-Z]+(-)*[a-zA-Z]*(-)*[a-zA-Z]*(-)*[a-zA-Z]*"/)
   # intermediate << pa.name
  #end
  #end
  #p "intermediate: #{intermediate.count}"
  #if pa.name.match(/^[a-zA-Z]+$/)
  #intermediate.each do |item|
    #if pa.name.match(/\w{2}:/)
      #rest << pa.name
    #elsif pa.name.match(/.*\d\.*/)
      #rest << pa.name
    #elsif pa.name.size = 1
      #rest << pa.name
    #else
      #results << pa.name
    #end
  #end
#end


#results.each do |res|
  #p res
#end
#p results.count
#p "rest: #{rest.count}"
# unless pa.name.match(/\w{2}:/)   666 results
# unless pa.name.match(/\w{2}:/) || pa.name.match(/.*\d\.*/) . 672 results
# unless pa.name.match(/^"\w{1}"/)  681 results



#/"[a-zA-Z]+(-)*[a-zA-Z]+(-)*[a-zA-Z]*(-)*[a-zA-Z]*(-)*[a-zA-Z]*"/

# <style>
# body {
   # min-height: 100vh;
   # background-color: #00d2ff;
  # background-image: linear-gradient(to right, #00d2ff 0%, #3a7bd5 100%);
# }

# .bg-gradient {
   # background-color: #00d2ff;
   # background-image: linear-gradient(to right, #00d2ff 0%, #3a7bd5 100%);
   # box-shadow: 2px 2px 10px rgba(57, 123, 213, 0.36)
# }
# </style>
# <div class="card shadow mb-4">
                # <div class="card-body p-5">
                   #  <h4>Multiple progress bars</h4>
                   #  <p class="font-italic text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>

                   #  <!-- Multiple progress bar-->
                   #  <div style="height: 4px" class="progress rounded-pill">
                       #  <div role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%" class="progress-bar"></div>
                       #  <div role="progressbar" aria-valuenow="22" aria-valuemin="0" aria-valuemax="100" style="width: 22%" class="progress-bar bg-warning"></div>
                       #  <div role="progressbar" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" style="width: 15%" class="progress-bar bg-danger"></div>
                   #  </div>
               #  </div>
           #  </div>

# </section>
