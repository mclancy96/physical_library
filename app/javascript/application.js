import {Toast} from 'bootstrap';

document.addEventListener('DOMContentLoaded', () => {
    const toastElList = document.querySelectorAll('.toast');
    toastElList.forEach((toastEl) => {
        const toast = new Toast(toastEl);
        toast.show();
    });
});