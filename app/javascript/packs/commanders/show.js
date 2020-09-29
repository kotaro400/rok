const upRipples = document.getElementsByClassName("up");

if (upRipples) {
  for(let i = 0; i < upRipples.length; i++){
    upRipples[i].onclick = function(e) {
        const X = e.pageX - this.offsetLeft;
        const Y = e.pageY - this.offsetTop;
        let rippleDiv = document.createElement("div");
        rippleDiv.classList.add('ripple');
        rippleDiv.setAttribute("style","top:"+Y+"px; left:"+X+"px;");
        upRipples[i].appendChild(rippleDiv);
        setTimeout(function() {
            rippleDiv.remove();
        },1200);
    }
  }
}

const downRipples = document.getElementsByClassName("down");

if (downRipples) {
  for(let i = 0; i < downRipples.length; i++){
    downRipples[i].onclick = function(e) {
        const X = e.pageX - this.offsetLeft;
        const Y = e.pageY - this.offsetTop;
        let rippleDiv = document.createElement("div");
        rippleDiv.classList.add('ripple');
        rippleDiv.setAttribute("style","top:"+Y+"px; left:"+X+"px;");
        downRipples[i].appendChild(rippleDiv);
        setTimeout(function() {
            rippleDiv.remove();
        },1200);
    }
  }
}
