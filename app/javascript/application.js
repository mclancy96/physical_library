import * as ActiveStorage from "@rails/activestorage";
import "./controllers/toast"
import "./controllers/scan_book"
import "./controllers/book_likes"
import "bootstrap"

// Initialize Rails UJS and ActiveStorage
ActiveStorage.start()
document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('[data-bs-toggle="popover"]').forEach(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl))
});

