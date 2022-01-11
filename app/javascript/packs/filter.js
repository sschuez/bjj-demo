import Rails from '@rails/ujs';

var checkBoxes = document.querySelectorAll(".form-check-input");
var form = document.querySelector('form');

for (const check of checkBoxes) {
check.addEventListener('change', function() {
  Rails.fire(form, 'submit');
});
}

// const filters = document.querySelector(".filter-card");
// console.log(filters);

// const button = document.querySelector(".filter-btn");
// console.log(button);

// button.addEventListener('click', (event) => {
// 	console.log(event);
// 	console.log(event.currentTarget);

// 	event.currentTarget.classList.toggle("active");
// });
