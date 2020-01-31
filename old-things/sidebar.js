const sideBar = document.querySelector('.sidebar');
const blackHamburger = document.querySelector('.black-hamburger');
const whiteHamburger = document.querySelector('.white-hamburger');
const titles = document.body.querySelectorAll('.post-title');

titles.forEach(title => {
  let item = document.createElement('p');
  item.innerText = title.innerText;
  sideBar.appendChild(item);
})

whiteHamburger.addEventListener('click', openClose);
blackHamburger.addEventListener('click', openClose);

function openClose() {
  if (sideBar.offsetWidth) {
    sideBar.style.width = '0';
  } else {
    sideBar.style.width = '200px';
  }
}