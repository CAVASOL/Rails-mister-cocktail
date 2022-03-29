const shareCocktail = () => {
  const btn = document.getElementById("share-cocktail")
  if (btn) {
    btn.addEventListener("click", () => {
      const data = {
        url: window.location.href,
        title: btn.dataset.name,
        text: btn.dataset.instruction,
      }

      if (navigator.share) {
        navigator.share(data)
      }
    })
  }
};

export { shareCocktail }
