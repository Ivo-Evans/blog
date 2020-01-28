const sideBar = document.querySelector('.sidebar');
const hamburger = document.querySelector('.sidebar-button');

sideBar.addEventListener('click', openClose);
hamburger.addEventListener('click', openClose);

function openClose() {
  if (sideBar.offsetWidth) {
    sideBar.style.width = '0';
  } else {
    sideBar.style.width = '200px';
  }
}