function buildCell(rowIndex) {
  const cell = rowIndex ? document.createElement('td') : document.createElement('th');
  if (!rowIndex) cell.setAttribute('scope', 'col');
  return cell;
}

export default function decorate(block) {
  const table = document.createElement('table');
  const thead = document.createElement('thead');
  const tbody = document.createElement('tbody');
  table.append(thead, tbody);
  [...block.children].forEach((child, rowIndex) => {
    const row = document.createElement('tr');
    (rowIndex ? tbody : thead).append(row);
    [...child.children].forEach((col) => {
      const cell = buildCell(rowIndex);
      cell.innerHTML = col.innerHTML;
      row.append(cell);
    });
  });
  block.replaceChildren(table);
}
