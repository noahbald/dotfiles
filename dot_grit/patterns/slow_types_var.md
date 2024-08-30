---
level: warn
tags: [performance, slow-types]
---

Exported functions should be given an explicit type

```grit
engine marzano(0.1)
language js

and {
    or {
        `$name = $value` where {
            and {
                or {
                    $program <: contains `export default $name`,
                    $program <: contains `export const $name = $value`,
                    $program <: contains `export let $name = $value`,
                    $program <: contains `export var $name = $value`,
                },
                or {
                    $value <: `[ $_ ]`,
                    $value <: `{ $_ }`,
                },
            },
        },
        `export default [ $_ ]`,
        `export default { $_ }`,
    },
    !`export default $_ as $_`,
    !`$_: $_ = $_`,
}
```

## Default unnamed array

```ts
export default [];
```

## Default unnamed object

```ts
export default {};
```

## Default named

```ts
const myObject = {};
export default myObject;
```

## Named object

```ts
export const myObject = {};
```

## Named array

```ts
export const myArray = [];
```
