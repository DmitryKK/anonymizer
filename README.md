# Anonymizer

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `anonymizer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:anonymizer, "~> 0.1.0"}
  ]
end
```

## Getting Started

### Start

Current library supports map structure only. Input data structure must be map with atom keys.

Example:

```elixir
iex> data = %{
    customer: %{
      name: "Andrew",
      surname: "Yudin",
      email: "andrew@channex.io"
    },
    checkin_date: "2019-02-20",
    checkout_date: "2019-02-21"
  }
```

Pattern for handling must be list of tuples. Each tuple consists of a string as path to record and a atom as type of handling.

Example:

```elixir
iex> profile = [
  {"customer/name", :mask},
  {"customer/surname", :mask},
  {"customer/email", :drop}
]
```

### Execution

```elixir
iex> Anonymizer.anonymize(data, profile)
{:ok, %{
  checkin_date: "2019-02-20",
  checkout_date: "2019-02-21",
  customer: %{name: "A*!*$w", surname: "Y~#*n"}
}
```
