---
level: warn
tags: [performance, slow-types]
---

# Destructuring exports

Export each symbol individually

```grit
engine marzano(0.1)
language js

`export const { $_ } = $_`
```

## Example

```ts
export const { foo, bar } = { foo: "foo", bar: "bar" };
```
