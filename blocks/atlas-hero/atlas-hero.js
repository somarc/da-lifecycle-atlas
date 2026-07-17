/**
 * Decorates the Atlas lead block.
 * Authoring contract: one row; first cell is narrative, optional second cell is media.
 * @param {Element} block The block element
 */
export default function decorate(block) {
  const row = block.firstElementChild;
  if (!row) return;
  row.classList.add('atlas-hero-layout');
  [...row.children].forEach((cell, index) => {
    cell.classList.add(index ? 'atlas-hero-media' : 'atlas-hero-copy');
  });
  const firstParagraph = row.querySelector('.atlas-hero-copy > p:first-child');
  if (firstParagraph) firstParagraph.classList.add('atlas-kicker');
}
