# ex_banking_erl

```
./rebar3 ct
./rebar3 eunit
```

## Running under elixir

In `config/config.exs`:
```
...
config :ex_banking, [
  shards_count: 8
]
```

Then
```
iex -S mix
Erlang/OTP 20 [erts-9.0] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:10] [hipe] [kernel-poll:false]

Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> :application.start(:ex_banking)
:ok
iex(2)> :application.which_applications
[{:ex_banking, 'Heathmont test assignment', '0.1.0'}, {:hex, 'hex', '0.17.1'},
 {:inets, 'INETS  CXC 138 49', '6.4'},
 {:ssl, 'Erlang/OTP SSL application', '8.2'},
 {:public_key, 'Public key infrastructure', '1.4.1'},
 {:asn1, 'The Erlang ASN1 compiler version 5.0', '5.0'},
 {:crypto, 'CRYPTO', '4.0'}, {:mix, 'mix', '1.5.2'}, {:iex, 'iex', '1.5.2'},
 {:elixir, 'elixir', '1.5.2'}, {:compiler, 'ERTS  CXC 138 10', '7.1'},
 {:stdlib, 'ERTS  CXC 138 10', '3.4'}, {:kernel, 'ERTS  CXC 138 10', '5.3'}]
iex(3)> :ex_banking.create_user("Max")
:ok
iex(4)> :ex_banking.deposit("Max", 10.34, "USD")
{:ok, 10.34}
iex(5)> :ex_banking.withdraw("Max", 5.0, "USD")
{:ok, 5.34}
iex(6)>
```
