/**
 * Decorates side-by-side eras or concepts.
 * Authoring contract: each row has two authored cells.
 * @param {Element} block The block element
 */
export default function decorate(block) {
  [...block.children].forEach((row) => {
    row.classList.add('atlas-compare-row');
    [...row.children].forEach((cell, index) => {
      cell.classList.add('atlas-compare-panel', index ? 'atlas-compare-new' : 'atlas-compare-old');
    });
    if (row.children.length > 1) {
      const arrow = document.createElement('span');
      arrow.className = 'atlas-compare-arrow';
      arrow.setAttribute('aria-hidden', 'true');
      arrow.textContent = '→';
      row.children[0].after(arrow);
    }
  });
}
