// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import {Html5Qrcode} from "html5-qrcode";

const scanButton = document.getElementById("scan-barcode-btn");
const reader = document.getElementById("reader");
const bookInfoDiv = document.getElementById("book-info");

if (scanButton) {
    scanButton.addEventListener("click", () => {
        reader.style.display = "block";
        const html5QrCode = new Html5Qrcode("reader");

        const qrCodeSuccessCallback = (decodedText, decodedResult) => {
            reader.style.display = "none";
            html5QrCode.stop().then(() => {
                bookInfoDiv.innerHTML = "Loading book information...";

                // Send ISBN to Rails to fetch and save the book data
                fetch(`/books/scan`, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                    },
                    body: JSON.stringify({isbn: decodedText})
                }).then(response => {
                    console.log("This is the response", response)
                    // Check if response is ok (status 200-299)
                    if (!response.status) {
                        console.log("The response was not ok. Here's the data", reponse.data);
                        bookInfoDiv.innerHTML = `<p>Error occurred: ${data.errors.join(', ')}</p>`;
                        location.reload();
                        return;
                    }
                    return response.json();
                })
                    .then(data => {
                        console.log("data from controller", data);
                        if (data.success) {
                            bookInfoDiv.innerHTML = `
                  <p><strong>Title:</strong> ${data.book.title}</p>
                  <p><strong>Author:</strong> ${data.book.author.name}</p>
                  <p><strong>Genre:</strong> ${data.book.genre.name}</p>
                  <img src="${data.book.cover_image_url}" alt="Book cover" style="width: 100px;">
                `;
                        } else {
                            bookInfoDiv.innerHTML = `<p>Error occurred: ${data.errors.join(', ')}</p>`;
                            location.reload();
                        }
                    }).catch(error => {
                    console.error("Error fetching book data:", error);
                    bookInfoDiv.innerHTML = `<p>Error occurred while fetching book data.</p>`;
                });
            });
        };

        const qrCodeErrorCallback = errorMessage => {
            return Promise.reject(errorMessage);
        };

        html5QrCode.start(
            {facingMode: "environment"},
            {fps: 10, qrbox: 250},
            qrCodeSuccessCallback,
            qrCodeErrorCallback
        );
    });
}