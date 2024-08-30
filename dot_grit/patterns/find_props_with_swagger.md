---
level: info
tags: [atdw]
---

# Find prop interfaces that use swagger types

```grit
engine marzano(0.1)
language js

pattern props_use_swagger() {
    or {
        `interface $interface { $entries }`,
        `interface $interface extends $extension { $_ }`
    } where {
        and {
            $interface <: r"\w*Props$",
            $program <: contains bubble($entries, $extension) or {
                `import { $imports } from "@/types/swagger"` where {
                    $imports <: contains bubble($entries, $extension) or {
                        `$type` where {
                            or {
                                $entries <: contains $type,
                                $type <: contains $extension
                            }
                        }
                    }
                }
            }
        }
    }
}
```
