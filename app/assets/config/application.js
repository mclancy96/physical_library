import "bootstrap";
import '@popperjs/core';
import "../../assets/stylesheets/application.scss"; // If you have stylesheets, ensure this is correct
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";

Rails.start();
Turbolinks.start();
ActiveStorage.start();