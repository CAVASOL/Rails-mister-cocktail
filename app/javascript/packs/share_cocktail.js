const shareCocktail = () => {
  const shareButton = document.getElementById("share-cocktail")
  if (shareButton) {
    shareButton.addEventListener("click", () => {
      const data = {
        url: window.location.href,
        title: btn.dataset.name,
        text: btn.dataset.instruction,
      }

      if (navigator.share) {
        navigator.share(data)
      }
    }).then(() => {
      console.log('Thanks for sharing!')
    })
    .catch(console.error);
  } else {
    // fallback
  }
};


export { shareCocktail }
