const shareCocktail = () => {
  const btn = document.getElementById("share-cocktail")
  if (shareCocktailBtn) {
    shareCocktailBtn.addEventListener("click", () => {
      const data = {
        url: window.location.href,
        title: btn.dataset.name,
      }

      if (navigator.share) {
        navigator.share(data)
      }
    })
  }
}

export { shareCocktail }
