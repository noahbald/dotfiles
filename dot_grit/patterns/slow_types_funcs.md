---
    level: warn
    tags: [performance, slow-types]
---

# Slow function types

Exported functions should have an explicit return type

```grit
engine marzano(0.1)
language js

and {
    or {
        or { `function $name($_) { $_ }`,  `$name = ($_) => $_` } where {
            or {
                $program <: contains `export default $name`,
                $program <: contains `export const $_ = $name`,
                $program <: contains `export function $name ($_) { $_ }`,
            },
        },
        `export default ($_) => $_`,
        `export default function $_ ($_) { $_ }`,
        `export const $_ = function $_ ($_) { $_ }`,
    },
    !`function $_($_): $_ { $_ }`,
    !`$_ = (): $_ => $_`,
    !`$_: $_ = () => $_`,
}
```

## Default function export

```ts
export default function () {}
```

## Default arrow export

```ts
export default () => {};
```

## Default named export

```ts
function namedFunction() {}
export default namedFunction;
```

## Default named arrow export

```ts
const namedArrow = () => {};
export default namedArrow;
```

## Named function

```ts
export const anonymousFunction = function () {};
```

## Named arrow

```ts
export const arrowFunction = () => {};
```
