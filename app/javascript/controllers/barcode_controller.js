import { Controller } from "@hotwired/stimulus"
import { Html5QrcodeScanner} from "html5-qrcode";

// Connects to data-controller="barcode"
export default class extends Controller {

  static targets = ["content", "barcodeInput", "nameInput", "ecoscoreInput", "packagingTagsInput", "imageUrlInput", "scanner"]
  connect() {
    console.log('connecting barcode cont')
    let lastResult, countResults = 0;
    const arrayCategories = [
        "Rigid plastic", "Plastic film", "Metal" , "Glass", "Biodegradable", "Paper"
      ]


    const arrayTypes = [

      "HDPE",
      "PP",
      "PVC",
      "Polystyrene",
      "Mixed Plastic",
      "Mixed Plastic Film",
      "HDPE Film",
      "LDPE",
      "PP Film",
      "Glass",
      "Aluminium",
      "Foil",
      "Steel",
      "Paper",
      "Card",
      "Compostable",
      "Biodegradable",
      "Composite",
      "PET"]


    const onScanSuccess = (decodedText, decodedResult) => {

      // or we do type and category array

        if (countResults === 0) {
            ++countResults;
            lastResult = decodedText;
            // Handle on success condition with the decoded message.
            // console.log(`Scan result ${decodedText}`, decodedResult);
            html5QrcodeScanner.clear();

            const requestOptions = {
              method: 'GET',
              redirect: 'follow'
            };
            // console.log(decodedText);
            fetch(`/items/find/${decodedText}`, {headers: {"Accept": "application/json"}})
            .then(response => response.json())
            .then((data) => {

              console.log(data)
              this.scannerTarget.classList.add("d-none")

              if (data.form) {
                this.contentTarget.innerHTML = data.form
                fetch(`https://world.openfoodfacts.org/api/v0/product/${decodedText}.json`, requestOptions)
                .then(response => response.json())
                .then(result => {
                    console.log(`result["product"]`, result["product"])
                    // document.querySelector("#barcode-title").classList.add("d-none")
                    // console.log(this.barcodeInputTarget)
                    // console.log(result["product"]);
                    // console.log(result["product"]["code"]);
                      if((result["product"]["code"]) == undefined) {
                        // console.log("hello")
                      } else {
                        this.barcodeInputTarget.value = result["product"]["code"]
                      }

                      console.log(result["product"]["image_packaging_url"]);
                      if((result["product"]["image_packaging_url"]) == undefined) {
                        // console.log("hello")
                      } else {
                        // console.log("inside else")
                        this.imageUrlInputTarget.value = result["product"]["image_packaging_url"]
                      }


                      console.log(result["product"]["product_name"]);
                      if((result["product"]["product_name"]) == undefined) {
                        // console.log("hello")
                      } else {
                        this.nameInputTarget.value = result["product"]["product_name"]
                      }
                      console.log(result["product"]["packaging"]);
                      if((result["product"]["packaging"]) == undefined) {
                        // console.log("hello")
                      }
                      console.log(result["product"]["packaging_tags"]);
                      if((result["product"]["packaging_tags"]) == undefined) {
                        // console.log("hello")
                      } else {
                      //   this.packagingtagsInputTarget.value =
                        const packagingTypesFound = this.findPackagings(result["product"]["packaging_tags"], arrayTypes);
                        // console.log(array_categories.categories_type.find(el => el === result["product"]["packaging_tags"]))
                        packagingTypesFound.forEach((type) => {
                          // console.log(this.packagingTagsInputTargets)
                          // console.log(this.packagingTagsInputTargets[this.packagingTagsInputTargets.length - 1].options)
                          Array.from(this.packagingTagsInputTargets[this.packagingTagsInputTargets.length - 1].options).forEach((option,index)=> {
                            // console.log(option.innerText)
                            // console.log(type)
                            if (option.innerText.endsWith(type)) {
                              this.packagingTagsInputTargets[this.packagingTagsInputTargets.length - 1].selectedIndex = index
                            }
                          })
;
                        })
                      }
                      // console.log(result["product"]["ecoscore_grade"]);
                      if((result["product"]["ecoscore_grade"]) == undefined) {
                        // console.log("hello")
                      }else{
                        this.ecoscoreInputTarget.value = result["product"]["ecoscore_grade"]
                      }
                    })
                } else {
                  // this.contentTarget.innerHTML = data.show
                  // console.log(data)
                  window.location.replace(`/my_products/${data.id}`);

                }

              })




              // .catch(error => console.log('error', error));
              // console.log(typeof(result))

        }
        else {
          Html5QrcodeScanner.stop().then((ignore) => {
            // QR Code scanning is stopped.
          }).catch((err) => {
            // Stop failed, handle it.
          });
        }
    }

    const html5QrcodeScanner = new Html5QrcodeScanner(
      "qr-reader", { fps: 10, qrbox: { width: 250, height: 250} });

      console.log("rendering scanner")

      html5QrcodeScanner.render(onScanSuccess);

      // setTimeout(() => {
      //   const startBtn = document.getElementById("html5-qrcode-button-camera-start");
      //   const stopBtn = document.getElementById("html5-qrcode-button-camera-stop");
      //   startBtn.style.color = 'red'
      //   stopBtn.style.color = 'red'
      //   startBtn.style.backgroundColor = '#ABD699'
      //   stopBtn.style.backgroundColor = '#ABD699'
      // }, 2000);
  }



  findPackagings(apiArray, arrayTypes) {
      let foundTypes = []
      apiArray.forEach((apiString) => {
        // console.log(apiString)
        const cleanedString = apiString.split(":")[apiString.split(":").length - 1]
        // console.log(cleanedString)
        let cleanedStringFound = false
        arrayTypes.forEach((type) => {
          // console.log(`${type} and ${cleanedString}`)
          if (cleanedStringFound == false && type.toLowerCase() === cleanedString.toLowerCase() && foundTypes.indexOf(type) === -1 ) {
            // console.log(`found it`)
            foundTypes.push(type);
            cleanedStringFound = true;
          }

        });
        if (cleanedStringFound === false) {
          const cleanedStringArray = cleanedString.split("-");
          cleanedStringArray.forEach((chunk) => {
            let foundChunk = false
            arrayTypes.forEach((type) => {
              if (foundChunk == false && type.toLowerCase() === chunk.toLowerCase() && foundTypes.indexOf(type) === -1 ) {
                foundTypes.push(type);
                foundChunk = true;
              }
            })

          })
        }
      })
      // console.log(foundTypes)
      return foundTypes
  }

  disconnect() {
    Html5QrcodeScanner.stop().then((ignore) => {
      // QR Code scanning is stopped.
      console.log('stopping scanner')
    }).catch((err) => {
      // Stop failed, handle it.
      console.log(err)
    });
  }
}
