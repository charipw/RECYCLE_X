import { Controller } from "@hotwired/stimulus";
import { Html5QrcodeScanner } from "html5-qrcode";

// Connects to data-controller="barcode"
export default class extends Controller {
  static targets = [
    "content",
    "barcodeInput",
    "nameInput",
    "ecoscoreInput",
    "packagingTagsInput",
    "imageUrlInput",
    "scanner",
  ];
  html5QrcodeScanner = null;
  connect() {
    console.log("connecting barcode cont");
    let lastResult,
      countResults = 0;

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
      "PET",
    ];

    // Handle on success condition with the decoded message.
    const onScanSuccess = (decodedText) => {
      if (countResults === 0) {
        ++countResults;
        lastResult = decodedText;
        this.html5QrcodeScanner.clear();

        // console.log(decodedText);
        fetch(`/items/find/${decodedText}`, {
          headers: { Accept: "application/json" },
        })
          .then((response) => {
            return response.json();
          })
          .then((data) => {
            console.log(data);
            this.scannerTarget.classList.add("d-none");

            if (data.form) {
              this.contentTarget.innerHTML = data.form;
              fetch(
                `https://world.openfoodfacts.org/api/v0/product/${decodedText}.json`
              )
                .then((response) => response.json())
                .then((result) => {
                  if (result["product"]["code"]) {
                    this.barcodeInputTarget.value = result["product"]["code"];
                  }

                  if (result["product"]["image_url"]) {
                    this.imageUrlInputTarget.value =
                      result["product"]["image_url"];
                  }

                  if (result["product"]["product_name"]) {
                    this.nameInputTarget.value =
                      result["product"]["product_name"];
                  }

                  if (result["product"]["packaging_tags"]) {
                    const packagingTypesFound = this.findPackagings(
                      result["product"]["packaging_tags"],
                      arrayTypes
                    );
                    // console.log(array_categories.categories_type.find(el => el === result["product"]["packaging_tags"]))
                    // console.log("input", this.packagingTagsInputTargets);
                    packagingTypesFound.forEach((type) => {
                      // console.log(type);
                      // console.log(this.packagingTagsInputTargets[this.packagingTagsInputTargets.length - 1].options)
                      this.packagingTagsInputTargets.forEach(
                        (packagingInput) => {
                          // console.log(
                          //   packagingInput.parentElement.querySelector("label")
                          //     .innerText
                          // );
                          // console.log(
                          //   packagingInput.parentElement
                          //     .querySelector("label")
                          //     .innerText.replace(
                          //       packagingInput.parentElement
                          //         .querySelector("label")
                          //         .querySelector("hint").innerText,
                          //       ""
                          //     )
                          // );
                          if (
                            packagingInput.parentElement
                              .querySelector("label")
                              .innerText.replace(
                                packagingInput.parentElement
                                  .querySelector("label")
                                  .querySelector("hint").innerText,
                                ""
                              )
                              .toLowerCase()
                              .endsWith(type.toLowerCase())
                          ) {
                            packagingInput.checked = true;
                          }
                        }
                      );
                    });
                  }

                  if (result["product"]["ecoscore_grade"]) {
                    this.ecoscoreInputTarget.value =
                      result["product"]["ecoscore_grade"];
                  }
                });
            } else {
              window.location.replace(`/my_products/${data.id}`);
            }
          });
      } else {
        this.html5QrcodeScanner.stop();
      }
    };

    this.html5QrcodeScanner = new Html5QrcodeScanner("qr-reader", {
      fps: 10,
      qrbox: { width: 250, height: 250, border: "none" },
    });

    this.html5QrcodeScanner.render(onScanSuccess);
  }

  findPackagings(apiArray, arrayTypes) {
    let foundTypes = [];
    apiArray.forEach((apiString) => {
      const cleanedString =
        apiString.split(":")[apiString.split(":").length - 1];
      let cleanedStringFound = false;
      arrayTypes.forEach((type) => {
        // console.log(`${type} and ${cleanedString}`)
        if (
          cleanedStringFound == false &&
          type.toLowerCase() === cleanedString.toLowerCase() &&
          foundTypes.indexOf(type) === -1
        ) {
          // console.log(`found it`)
          foundTypes.push(type);
          cleanedStringFound = true;
        }
      });
      if (cleanedStringFound === false) {
        const cleanedStringArray = cleanedString.split("-");
        cleanedStringArray.forEach((chunk) => {
          let foundChunk = false;
          arrayTypes.forEach((type) => {
            if (
              foundChunk == false &&
              type.toLowerCase() === chunk.toLowerCase() &&
              foundTypes.indexOf(type) === -1
            ) {
              foundTypes.push(type);
              foundChunk = true;
            }
          });
        });
      }
    });
    // console.log(foundTypes)
    return foundTypes;
  }

  disconnect() {
    console.log(this.html5QrcodeScanner);
    this.html5QrcodeScanner
      .stop()
      .then((ignore) => {
        // QR Code scanning is stopped.
        console.log("stopping scanner");
      })
      .catch((err) => {
        // Stop failed, handle it.
        console.log(err);
      });
  }
}
