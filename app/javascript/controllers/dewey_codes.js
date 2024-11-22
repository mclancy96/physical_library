document.addEventListener("DOMContentLoaded", () => {
    const baseURL = "/dewey_codes/children";
    const dropdownContainer = document.getElementById("dewey-dropdowns");
    const selectedDeweyCodeField = document.getElementById("dewey_code_id");
    const hiddenField = document.getElementById("dewey_code_id");

    document.getElementById("dewey-level-1").addEventListener("change", (event) => {
        const selectedValue = event.target.value;
        hiddenField.value = this.value;
        if (selectedValue) {
            fetchChildDeweyCodes(selectedValue, 2);
        } else {
            clearDropdowns(2);
        }
    });

    function fetchChildDeweyCodes(parentId, level) {
        fetch(`${baseURL}?parent_id=${parentId}`)
            .then((response) => response.json())
            .then((data) => {
                updateDropdowns(data, level);
            });
    }

    function updateDropdowns(data, level) {
        clearDropdowns(level);

        if (data.length > 0) {
            const dropdown = document.createElement("select");
            dropdown.classList.add("form-select", "mb-3");
            dropdown.setAttribute("data-level", level); // Add data-level attribute
            dropdown.innerHTML = '<option value="">Select a category</option>';

            data.forEach((child) => {
                const option = document.createElement("option");
                option.value = child.id;
                option.textContent = `${child.code} - ${child.description}`;
                dropdown.appendChild(option);
            });

            dropdown.addEventListener("change", (event) => {
                const selectedValue = event.target.value;
                if (selectedValue) {
                    selectedDeweyCodeField.value = selectedValue;
                    fetchChildDeweyCodes(selectedValue, level + 1);
                } else {
                    clearDropdowns(level + 1);
                }
            });

            dropdownContainer.appendChild(dropdown);
        }
    }

    function clearDropdowns(fromLevel) {
        const dropdowns = dropdownContainer.querySelectorAll("select");
        dropdowns.forEach((dropdown) => {
            const level = parseInt(dropdown.dataset.level, 10);
            if (level >= fromLevel) {
                dropdown.remove();
            }
        });
    }
});