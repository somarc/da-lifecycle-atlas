/**
 * Embeds a same-origin Atlas visual and keeps the frame sized to its document.
 *
 * Authoring contract: the first link in the block points to a standalone HTML
 * visual under /visuals. Its link text becomes the accessible frame title.
 *
 * @param {Element} block The block element
 */
export default function decorate(block) {
  const source = block.querySelector('a[href]');
  if (!source) return;

  const url = new URL(source.href, window.location.href);
  if (url.origin !== window.location.origin || !url.pathname.startsWith('/visuals/')) {
    block.dataset.error = 'invalid-source';
    return;
  }

  const frame = document.createElement('iframe');
  frame.src = `${url.pathname}${url.search}${url.hash}`;
  frame.title = source.textContent.trim() || 'DA Lifecycle Atlas visual explainer';
  frame.loading = 'eager';
  frame.setAttribute('sandbox', 'allow-same-origin allow-scripts allow-popups');

  const resize = (event) => {
    if (event.origin !== window.location.origin || event.source !== frame.contentWindow) return;
    if (event.data?.type !== 'atlas-visual-height') return;
    if (event.data.path !== url.pathname) return;
    const height = Number(event.data.height);
    if (Number.isFinite(height) && height > 0) frame.style.height = `${height}px`;
  };

  window.addEventListener('message', resize);
  block.replaceChildren(frame);
}
