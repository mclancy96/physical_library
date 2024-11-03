import {Toast} from 'bootstrap';
import {Html5Qrcode} from "html5-qrcode";

document.addEventListener('DOMContentLoaded', () => {
    const toastElList = document.querySelectorAll('.toast');
    toastElList.forEach((toastEl) => {
        const toast = new Toast(toastEl);
        toast.show();
    });

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
                        body: JSON.stringify({ isbn: decodedText })
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                bookInfoDiv.innerHTML = `
                  <p><strong>Title:</strong> ${data.book.title}</p>
                  <p><strong>Author:</strong> ${data.book.author.name}</p>
                  <p><strong>Genre:</strong> ${data.book.genre.name}</p>
                  <img src="${data.book.cover_image_url}" alt="Book cover" style="width: 100px;">
                `;
                            } else {
                                bookInfoDiv.innerHTML = `<p>${data.error}</p>`;
                            }
                        });
                });
            };

            const qrCodeErrorCallback = errorMessage => console.warn(`QR error: ${errorMessage}`);

            html5QrCode.start(
                { facingMode: "environment" },
                { fps: 10, qrbox: 250 },
                qrCodeSuccessCallback,
                qrCodeErrorCallback
            );
        });
    }
});



