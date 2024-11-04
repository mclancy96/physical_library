import "bootstrap";
 import '@popperjs/core';
import "../../assets/stylesheets/application.scss"; // If you have stylesheets, ensure this is correct

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
Rails.start()
ActiveStorage.start()