# regnbue [![Build Status](https://travis-ci.org/Ragmaanir/regnbue.svg?branch=master)](https://travis-ci.org/Ragmaanir/regnbue)

Just some helper functions to format/color strings.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  regnbue:
    github: ragmaanir/regnbue
```

## Usage

```crystal
require "regnbue"

Regnbue.format_large_number(1234567)

#=> "1,234,567"

Regnbue.format_string({
  :white,
  "This is ",
  {:yellow,
    "the ",
    {:red, "last "},
    "warning ",
  },
  "for all of ",
  {:red, "you!"},
})
```

## Contributing

1. Fork it ( https://github.com/[your-github-name]/regnbue/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Ragmaanir](https://github.com/ragmaanir) - creator, maintainer
