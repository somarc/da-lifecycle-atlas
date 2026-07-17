/**
 * Decorates an authored sequence.
 * Authoring contract: one row per step; cells are label, title/body, optional code/detail.
 * @param {Element} block The block element
 */
export default function decorate(block) {
  const rows = [...block.children];
  rows.forEach((row, index) => {
    row.classList.add('atlas-flow-step');
    [...row.children].forEach((cell, cellIndex) => {
      cell.classList.add(`atlas-flow-cell-${cellIndex + 1}`);
    });
    if (index < rows.length - 1) {
      const arrow = document.createElement('div');
      arrow.className = 'atlas-flow-arrow';
      arrow.setAttribute('aria-hidden', 'true');
      arrow.textContent = '↓';
      row.after(arrow);
    }
  });
}
