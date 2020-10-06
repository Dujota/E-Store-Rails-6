import consumer from './consumer';

consumer.subscriptions.create('ProductsChannel', {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const storeElement = document.querySelector('main.store');

    if (storeElement) {
      storeElement.innerHTML = data.html; // the html: render_as_string gets mapped to the .html property
    }

    // must be after the html insert since that data would override any selected element that precedes it
    const productUpdated = document.getElementById(`${data.product_id}`);

    if (productUpdated) {
      productUpdated.classList.toggle('product-highlight');
    }
  },
});
