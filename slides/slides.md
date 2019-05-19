---
title: Warsztaty - Elixir
theme: ./slides/assets/style.css
revealOptions:
    transition: 'fade'
highlightTheme: 'monokai'
---

<!-- .slide: data-background="./assets/codest-opener.svg" id="opener" -->

# Elixir w praktyce

<br/>
<br/>
<br/>
<br/>

## Pawel J. Wal @ Codest 2019

---

## Zasady

* MINASWAN!
* Pytaj, przerywaj, poprawiaj
* "Nie wiem" jest OK
* Bez telefonów proszę

---

# Elixir

Note: Elixir. Co to w ogóle jest?

----

> Elixir is a dynamic, functional language designed for building scalable and maintainable applications.

> Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems (...)

&mdash; elixir-lang.org

Note: Na stronie elixir lang org przeczytamy ze jest to dynamiczny, funkcjonalny jezyk do tworzenia skalowalnych i utrzymywalnych aplikacji. I ze jest zbudowany w oparciu o Erlang VM.

----

# Erlang

* telekomy
* bankowość
* instant messaging

&mdash; erlang.org

Note: odpakujmy to moze od konca. Co to jest ten Erlang? Do kogo jest skierowany?

----

## Kto używa Erlanga?

* Facebook
* WhatsApp
* T-Mobile
* Motorola
* Ericsson

----

## Co używa Erlanga?

* RabbitMQ
* CouchDB
* Ejabberd

----

```erlang
%% https://github.com/ninenines/cowboy/blob/master/src/cowboy_http2.erl

-spec init(pid(), ranch:ref(), inet:socket(), module(),
	ranch_proxy_header:proxy_info() | undefined, cowboy:opts(),
	{inet:ip_address(), inet:port_number()}, {inet:ip_address(), inet:port_number()},
	binary() | undefined, binary()) -> ok.
init(Parent, Ref, Socket, Transport, ProxyHeader, Opts, Peer, Sock, Cert, Buffer) ->
	{ok, Preface, HTTP2Machine} = cow_http2_machine:init(server, Opts),
	State = set_timeout(#state{parent=Parent, ref=Ref, socket=Socket,
		transport=Transport, proxy_header=ProxyHeader,
		opts=Opts, peer=Peer, sock=Sock, cert=Cert,
		http2_init=sequence, http2_machine=HTTP2Machine}),
	Transport:send(Socket, Preface),
	case Buffer of
		<<>> -> loop(State, Buffer);
		_ -> parse(State, Buffer)
	end.
```

Note: Problem jest taki, ze erlang wyglada o tak.

---

# Elixir

* "Cukier" nad składnią Erlanga
* Kompiluje się do BEAM (bytecode dla Erlang VM)
* Sponsorowany przez Plataformatec

----

## Skalowalność

* "lekkie" wątki (nie OS threads)
* rozwiązanie problemów współbieżności (immutability, message passing)
* izolacja - uproszczone GC

W konsekwencji - lepsze wykorzystanie zasobów maszyny

----

## Odporność na błędy

* _"things will go wrong"_
* rozwiązanie - supervisors

Note: aplikacja w Elixirze składa się z tzw. supervision tree - supervisorów które mogą mieć pod sobą inne supervisory lub grupy dzieci. Jak coś klęknie supervisor restartuje aplikację do znanego dobrego stanu (reinicjalizuje odpowiednią część drzewa)

----

## Dynamizm

* Nie ma silnego typowania
* Jest pattern matching
* Są guard clauses
* Są definicje struktur

----

## Functional programming

* Dane nie mutują
* Nie ma obiektów
* Nie ma stanów
* Mamy takie przyjemności jak destrukturyzacja (przez pattern matching) i pipe operator `|>`

----

## Community

* Zamiast `bundle` jest `mix`
* Zamiast `rubygems.org` jest `hex.pm`
* Zamiast `Rubyist` jest `Alchemist` 😉

---

## Elixir: pierwsze 5 minut

----

### We can into Hello World

```elixir
IO.puts "Hello world"
```

Note: IO to modul, nie obiekt!

----

### Co to jest?

```elixir
['foo', 123, :bar]
```

<br/>

Note: to jest lista, nie tablica!

----

### Co to jest?

```elixir
['foo', 123, :bar]
```

https://hexdocs.pm/elixir/List.html

----

### Co to jest?

```elixir
:foo
```

<br/>

Note: to jest atom, nie symbol!

----

### Co to jest?

```elixir
:foo
```

https://hexdocs.pm/elixir/Atom.html

----

### Co to jest?

```elixir
%{name: "Paweł", surname: "Wal", age: 28, alchemist: :uhhh}
```

<br/>

Note: to jest mapa, nie hash!

----

### Co to jest?

```elixir
%{name: "Paweł", surname: "Wal", age: 28, alchemist: :uhhh}
```

https://hexdocs.pm/elixir/Map.html

----

### Co to jest?

```elixir
{"Paweł", 28, :uhhh}
```

<br/>

Note: to jest tupla, zauwaz brak % z przodu

----

### Co to jest?

```elixir
{"Paweł", 28, :uhhh}
```

https://hexdocs.pm/elixir/Tuple.html

----

### Dokończ zwrotkę

```elixir
person = %{name: "Paweł", surname: "Wal", age: 28}
%{name: name} = person
IO.puts name
```

Note: sprawdźmy w iex

----

### Programista wchodzi do baru

```elixir
programmer = %{name: "Paweł", surname: "Wal", age: 28}

def a_programmer_walks_into_a_bar(%{age: age}) when age >= 18 do
  IO.puts "To co zwykle?"
end

a_programmer_walks_into_a_bar(programmer)
```

Note: sprawdźmy w iex - bum!

----

### Programista wchodzi do baru

```elixir
programmer = %{name: "Paweł", surname: "Wal", age: 28}

defmodule Bar do
  def a_programmer_walks_into_a_bar(%{age: age}) when age >= 18 do
    IO.puts "To co zwykle?"
  end
end

Bar.a_programmer_walks_into_a_bar(programmer)
```

Note: sprawdźmy w iex

----

#### Młodszy programista wchodzi do baru

```elixir
programmer = %{name: "Paweł", surname: "Wal", age: 16}

defmodule Bar do
  def a_programmer_walks_into_a_bar(%{age: age}) when age >= 18 do
    IO.puts "To co zwykle?"
  end
end

Bar.a_programmer_walks_into_a_bar(programmer)
```

Note: sprawdźmy w iex

---

### Czas na praktykę!

<img src="./assets/shoot.gif">

---

### Testy

* `bundle exec rspec` => `mix test`
* `bundle exec rspec --format documentation` => `mix test --trace`
* `RSpec` => `ExUnit`

https://hexdocs.pm/ex_unit/ExUnit.html

----

### Doctests

* generowane z dokumentacji (sekcje `## Examples`)
* nie mymagają `ex_docs` (ale czemu nie!)
* przykłady - jak sekcja `iex`
* dokumentacja to testy, testujemy też dokumentację

Note: same plusy - dokumentacja jest aktualna, stanowi testy, jeśli docsy kłamią to testy nie przechodzą

---

### Debugowanie

* `IO.puts`

----

### Debugowanie ;)

* `IEx.pry` (musimy wcześniej `require IEx`)
* podobny do gema `pry`
* nie tak dobry dostęp do lokalnego stanu

----

### Debugger

* Elixir posiada wbudowany graficzny debugger
* można go używać wprost z `iex`

----

### Debugger

* `:debugger.start()` - start debuggera
* `:int.ni(NaszModul)` - instrumentacja modułu
* `:int.break(NaszModul, 42)` - breakpoint w linii 42

---

### Process

* Wszystko w Elixirze dzieje się w procesach
* Procesy są odizolowane i porozumiewają się przez message passing
* Nie tylko współbieżność ale i rozproszenie
* Nie OS processes!

https://elixir-lang.org/getting-started/processes.html

Note: message passing nie musi odbywać się lokalnie, klaster eliksirowy moze byc na wielu maszynach i wysylac sobie wiadomosci po sieci

----

### Process

* Process ma wewnętrzny stan 😮
* Stan Process zmieniamy via message passing

----

### Task

* Wrapper nad funkcją `spawn` tworzącą procesy
* Dostarcza lepszy error reporting

----

### Task ze stanem

```elixir
defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end
```

Note: stan przechowujemy bo wywołujemy na samych sobie metodę w której parametrem jest nasz stan
To nie jest busy loop! Receive pasywnie czeka na wiadomosc

----

### Task ze stanem

```elixir
iex> {:ok, pid} = KV.start_link
{:ok, #PID<0.62.0>}
iex> send pid, {:put, :hello, :world}
{:put, :hello, :world}
iex> send pid, {:get, :hello, self()}
{:get, :hello, #PID<0.41.0>}
iex> flush()
:world
:ok
```

Note: usage. Zeby na glownym procesie odebrac musimy zflushowac wiadomosci (nie mamy receive)

----

### Agent

* Agent to wrapper nad Task
* Dostarcza uproszczonego DSLa do powyższego zadania

https://elixir-lang.org/getting-started/mix-otp/agent.html

----

### Agent

```
iex> {:ok, agent} = Agent.start_link fn -> [] end
{:ok, #PID<0.57.0>}
iex> Agent.update(agent, fn list -> ["eggs" | list] end)
:ok
iex> Agent.get(agent, fn list -> list end)
["eggs"]
iex> Agent.stop(agent)
:ok
```

Note: Agent ma start, update i stop - prosciej go uzyc

----

### GenServer

* "Generic server"
* W praktyce do długo żyjących zadań użyjemy GenServera
* GenServery są "przemysłowo" stabilne
* Obsługują kilka rodzajów wiadomości

https://elixir-lang.org/getting-started/mix-otp/genserver.html

----

### call, cast i info

* `call` - synchroniczny; serwer musi odpowiedzieć (backpressure)
* `cast` - asynchroniczny, brak odpowiedzi
* `info` - generalne wiadomości, np. komenda zatrzymania

----

### Supervisor

* W Elixirze nie programujemy defensywnie
* _"Let it crash"_ - wróćmy do pewnego, dobrego stanu
* Ale jak padnie, kto to podniesie?

https://elixir-lang.org/getting-started/mix-otp/supervisor-and-application.html

----

### Supervisor

* Supervisor ma procesy-dzieci
* Różne strategie podnoszenia dzieci
* Najprostsza `:one_for_one`

Note: one_for_one mowi ze jak jedno dziecko padnie restartujemy tylko to dziecko. one_for_all na przyklad powoduje ze jak jedno dziecko padnie restartujemy wszystkie

----

### Application

* Pozwala nam zdefiniować "entrypoint" aplikacji
* W praktyce generuje Erlangowy `.app` przez `mix compile`
* Tak robilibyśmy deployment

---

# Pytania?

https://paweljw.github.io/elixir-workshop
https://github.com/paweljw/elixir-workshop

---

# [APLAUZ]
