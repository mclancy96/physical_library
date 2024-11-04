import "bootstrap";
 import '@popperjs/core';
import "../../stylesheets/application.scss"; // If you have stylesheets, ensure this is correct
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// Import your custom JavaScript files
import "./controllers/toast";
import "./controllers/scan_book";

Rails.start();
Turbolinks.start();
ActiveStorage.start();
// Your additional JavaScript code here
