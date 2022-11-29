import { Controller } from "@hotwired/stimulus"
import { Html5QrcodeScanner} from "html5-qrcode";

// Connects to data-controller="barcode"
export default class extends Controller {
  connect() {
    console.log("hello world")
    var resultContainer = document.getElementById('qr-reader-results');
    var lastResult, countResults = 0;

  function onScanSuccess(decodedText, decodedResult) {
      if (decodedText !== lastResult) {
          ++countResults;
          lastResult = decodedText;
          // Handle on success condition with the decoded message.
          console.log(`Scan result ${decodedText}`, decodedResult);

          var requestOptions = {
            method: 'GET',
            redirect: 'follow'
          };

          fetch(`https://world.openfoodfacts.org/api/v0/product/${decodedText}.json`, requestOptions)
            .then(response => response.text())
            .then(result => console.log(result))
            .catch(error => console.log('error', error));

      }
  }

  var html5QrcodeScanner = new Html5QrcodeScanner(
      "qr-reader", { fps: 10, qrbox: 250 });
  html5QrcodeScanner.render(onScanSuccess);
    }

  }
