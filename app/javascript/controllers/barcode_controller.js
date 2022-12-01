import { Controller } from "@hotwired/stimulus"
import { Html5QrcodeScanner} from "html5-qrcode";

// Connects to data-controller="barcode"
export default class extends Controller {
  static targets = ["content"]
  connect() {
    let lastResult, countResults = 0;

    const onScanSuccess = (decodedText, decodedResult) => {

        if (countResults === 0) {
            ++countResults;
            lastResult = decodedText;
            // Handle on success condition with the decoded message.
            console.log(`Scan result ${decodedText}`, decodedResult);
            html5QrcodeScanner.clear();

            const requestOptions = {
              method: 'GET',
              redirect: 'follow'
            };
            console.log(decodedText);
            fetch(`/items/find/${decodedText}`, {headers: {"Accept": "application/json"}})
              .then(response => response.json())
              .then((data) => {
                console.log(data)
                if (data.form) {
                  this.contentTarget.innerHTML = data.form
                  fetch(`https://world.openfoodfacts.org/api/v0/product/${decodedText}.json`, requestOptions)
                    .then(response => response.json())
                    .then(result => {
                      console.log(result["product"]);
                      console.log(result["product"]["code"]);
                      console.log(result["product"]["product_name"]);
                      console.log(result["product"]["packaging"]);
                      console.log(result["product"]["packaging_tags"]);
                      console.log(result["product"]["ecoscore_grade"]);
                    })
                } else {
                  this.contentTarget.innerHTML = data.show
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
      "qr-reader", { fps: 10, qrbox: 250 });
      html5QrcodeScanner.render(onScanSuccess);
    }

  }
