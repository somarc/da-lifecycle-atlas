/**
 * Turns authored rows into semantic Atlas cards.
 * Authoring contract: one row per card; cells remain ordered card regions.
 * @param {Element} block The block element
 */
export default function decorate(block) {
  const cards = [...block.children].map((row) => {
    const card = document.createElement('article');
    card.className = 'atlas-grid-card';
    while (row.firstElementChild) card.append(row.firstElementChild);
    return card;
  });
  block.replaceChildren(...cards);
}
