function stepToRecorderAction(step) {
  const p = step.params || {};
  switch (step.action) {
    case 'goto':
      return { name: 'navigate', url: p.url, signals: [] };
    case 'goBack':
      return null;
    case 'goForward':
      return null;
    case 'reload':
      return null;
    case 'click':
      return p.selector ? { name: 'click', selector: p.selector, signals: [], button: 'left', modifiers: 0, clickCount: 1, position: p.position || undefined } : null;
    case 'fill':
      return (p.selector && p.value != null) ? { name: 'fill', selector: p.selector, text: String(p.value), signals: [] } : null;
    case 'type':
      return (p.selector && p.text != null) ? { name: 'fill', selector: p.selector, text: String(p.text), signals: [] } : null;
    case 'press':
      return { name: 'press', selector: p.selector || '', key: p.key, modifiers: 0, signals: [] };
    case 'hover':
      return p.selector ? { name: 'click', selector: p.selector, signals: [], button: 'none', modifiers: 0, clickCount: 0 } : null;
    case 'selectOption':
      return p.selector ? { name: 'select', selector: p.selector, options: [].concat(p.values || p.value || []), signals: [] } : null;
    case 'check':
      return p.selector ? { name: 'check', selector: p.selector, signals: [] } : null;
    case 'uncheck':
      return p.selector ? { name: 'uncheck', selector: p.selector, signals: [] } : null;
    default:
      return null;
  }
}

module.exports = { stepToRecorderAction };
