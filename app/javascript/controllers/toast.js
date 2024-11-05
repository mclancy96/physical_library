import {Toast} from "bootstrap";

const selectToast = () => {
    console.log("Toast has loaded");
    const toastElList = document.querySelectorAll('.toast');
    toastElList.forEach((toastEl) => {
        const toast = new Toast(toastEl);
        toast.show();
    });
}

if (document.readyState !== "loading") {
    selectToast();
} else {
    document.addEventListener('DOMContentLoaded', selectToast, {once: true});
}


