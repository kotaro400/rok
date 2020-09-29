document.addEventListener("turbolinks:load", function(){
  const open = document.getElementById("open-counts")
  const counts = document.getElementById("sculpture-counts")

  if (open && counts) {
    open.addEventListener("click", function(){
      if (counts.style.display === "block") {
        counts.style.display = ""
      }else{
        counts.style.display = "block"
      }
    })
  }
})
