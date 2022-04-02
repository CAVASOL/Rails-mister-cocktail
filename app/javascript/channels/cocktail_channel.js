import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  const cocktailsInInbox = document.querySelectorAll('#cocktail-inbox .cocktail-card-link');

  if (messagesContainer) {
    const id = messagesContainer.dataset.cocktailId;

    consumer.subscriptions.create({ channel: "CocktailChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data);
      },
    });
  }

  if (cocktailsInInbox) {
    cocktailsInInbox.forEach((cocktail) => {
      const id = cocktail.dataset.coctailId;

      consumer.subscriptions.create({ channel: "CocktailChannel", id: id }, {
        received(data) {
          const container = cocktail.querySelector(`#last-cocktail-${id}-message`);
          container.innerHTML = data;
        }
      })
    })
  }
}



export { initChatroomCable };
