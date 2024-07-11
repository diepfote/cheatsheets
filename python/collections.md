# Python collections

All of this is snatched from <https://richardoyudo.com/posts/dataclass-vs-namedtuple-code-generators/>

## Data classes

```text
from dataclasses import dataclass, field

@dataclass(order=True, frozen=True)
class Order:
    name: str
    recipient: str
    address: str = field(compare=False, repr=False, metadata={'address_type': 'shipping'})
    shipped: bool = False
    amount: float = 0
    
    def tax_due(self) -> float:
        return self.amount * 5 / 100
```

## NamedTuple


```text
from collections import namedtuple

Order = namedtuple('Order', 'name recipient address')  # Declaration of the named tuple
order = Order(name='Face mask', recipient='Anastasia', address='10, Miso Street')
```

