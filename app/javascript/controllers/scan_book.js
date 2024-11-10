// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import {Html5Qrcode} from "html5-qrcode";

const scanButton = document.getElementById("scan-barcode-btn");
const reader = document.getElementById("reader");
const bookInfo = document.getElementById("book-info");
const bookInput = document.getElementById("book-input");
const bookScanForm = document.getElementById("book-scan");

if (scanButton) {
    scanButton.addEventListener("click", () => {
        reader.style.display = "block";
        const html5QrCode = new Html5Qrcode("reader");
        bookInfo.innerText = "Reading text...";
        const qrCodeSuccessCallback = (decodedText, decodedResult) => {
            reader.style.display = "none";
            bookInput.value = decodedText;
            bookScanForm.submit();
            html5QrCode.stop().then(r => {});
        }

        const qrCodeErrorCallback = () => {
            bookInfo.innerText = `Error reading barcode.`;
        };

        html5QrCode.start(
            {facingMode: "environment"},
            {fps: 10, qrbox: 250},
            qrCodeSuccessCallback,
            qrCodeErrorCallback
        ).catch(error => {
            console.error("Error starting reader. Error:", error);
            bookInfo.innerText = `Error starting reader. Try again.`;
        });
    });
}