# Setup

```bash
$ mix new example-1 --app bar
```

In mix.exs, add a dep:

```elixir
  [
    {:ex_doc, "~> 0.19", only: :dev, runtime: false},
  ]
```

```bash
$ mix deps.get
$ mix docs
$ open doc/index.html
```

Tests and doctests:

```bash
$ mix test
$ mix test --trace
```

# Talk about

1. Modules
2. @moduledoc
3. Why do we even do docs? (Auto rendering, examples etc)
4. Build `drink_list`
5. Run in `iex`, add an example to code
6. Show off doctests
7. Show off regenerated docs
8. Move config vars (volumes/ drinks) to `config.exs`
9. Update method, show off method and specs still working, show off IEX recompile
10. Implement `pour_me_another`
11. Instrument the module with a debugger: `:debugger.start()` `:int.ni(Bar)` `:int.break(Bar, 37)`
12. Show off dropping into the debugger and what is actually in rest and bar
13. Update method to use `_` to denote unused variables
14. Talk about Process, Agent and GenServers
15. Talk about call, cast and info
16. Discuss the code for Bar itself
17. Discuss code in Customer
18. Show off running supervision tree
19. )take questions
