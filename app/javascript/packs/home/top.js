const openForm = document.getElementById("open-form")

if (openForm) {
  openForm.addEventListener("click", function(){
    const form = document.getElementById("contact-form")
    if (form.style.display === "block") {
      form.style.display = ""
    }else {
      form.style.display = "block"
    }
  })
}
