// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import {Html5Qrcode} from "html5-qrcode";

const scanButton = document.getElementById("scan-barcode-btn");
const reader = document.getElementById("reader");
const bookInfoInput = document.getElementById("book-info");
const bookScanForm = document.getElementById("book-scan");

if (scanButton) {
    scanButton.addEventListener("click", () => {
        reader.style.display = "block";
        const html5QrCode = new Html5Qrcode("reader");
        bookInfoInput.value = "Reading text...";
        const qrCodeSuccessCallback = (decodedText, decodedResult) => {
            console.log(decodedText);
            console.log(decodedResult);
            reader.style.display = "none";
            bookInfoInput.value = decodedText;
            console.log("The value of the book info input is:", bookInfoInput.value);
            bookScanForm.submit();
            html5QrCode.stop().catch(error => {
                    console.error("Error reading barcode. Found:", decodedText, "Error:", error);
                    bookInfoInput.value = `Error reading barcode.`;
                });
        };

        const qrCodeErrorCallback = () => {
            bookInfoInput.value = `Error reading barcode.`;
        };

        html5QrCode.start(
            {facingMode: "environment"},
            {fps: 10, qrbox: 250},
            qrCodeSuccessCallback,
            qrCodeErrorCallback
        ).catch(error => {
            console.error("Error starting reader. Error:", error);
            bookInfoInput.value = `Error starting reader. Try again.`;
        });
    });
}