const shareCocktail = () => {
  const shareButton = document.getElementById("share-cocktail")
  if (shareButton) {
    shareButton.addEventListener("click", () => {
      const data = {
        url: window.location.href,
        title: shareButton.dataset.name,
        text: shareButton.dataset.instruction,
      }

      if (navigator.share) {
        navigator.share(data)
      }
    })
  }
};


export { shareCocktail }
