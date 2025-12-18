# Javascript Snippets for RT 

## Collapses all double letters in between brackets into a single letter

```javascript
// Turns bbreasts into breast (inject into script or run in console)
const collapseBrackets = (str) => str.replace(/\[([^\]]*)\]/g, (_, word) => word.replace(/(.)\1+/g, '$1')); el.value = el.innerText = collapseBrackets(originalValue);
```
