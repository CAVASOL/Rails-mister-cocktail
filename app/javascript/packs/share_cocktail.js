const shareCocktail = () => {
  const btn = document.getElementById("share-cocktail")
  if (btn) {
    btn.addEventListener("click", () => {
      const data = {
        url: window.location.href,
        name: btn.dataset.name,
      }

      if (navigator.share) {
        navigator.share(data)
      }
    })
  }
}

export { shareCocktail }
