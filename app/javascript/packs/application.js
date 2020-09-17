// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("turbolinks:load", function(){
  const open = document.getElementById("open-menu")
  if (open) {
    open.addEventListener("click", function() {
      fadeIn(document.querySelector(".menu"), 300)
    })
  }

  const close = document.getElementById("close-menu")
  if (close) {
    close.addEventListener("click", function() {
      document.querySelector(".menu").style.display = ""
    })
  }

  const notice = document.querySelector(".notice")
  if(notice) {
    setTimeout(function() {
      notice.classList.add('fadeout');
      setTimeout(function() {
        notice.style.display = "none"
      }, 1000)
    }, 3000)
  }

  const alert = document.querySelector(".alert")
  if(alert) {
    setTimeout(function() {
      alert.classList.add('fadeout');
      setTimeout(function() {
        alert.style.display = "none"
      }, 1000)
    }, 3000)
  }

})

function fadeIn(node, duration) {
  if (getComputedStyle(node).display !== 'none') return;

  if (node.style.display === 'none') {
    node.style.display = '';
  } else {
    node.style.display = 'block';
  }
  node.style.opacity = 0;

  var start = performance.now();

  requestAnimationFrame(function tick(timestamp) {
    var easing = (timestamp - start) / duration;

    node.style.opacity = Math.min(easing, 1);

    if (easing < 1) {
      requestAnimationFrame(tick);
    } else {
      node.style.opacity = '';
    }
  });
}
