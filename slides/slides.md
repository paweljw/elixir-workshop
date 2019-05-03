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

# Skalowalność

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

### Testy i doctesty

---

### Debugger

---

### Process, Agent i Genserver

---

### call, cast i info

---

# Pytania?

https://paweljw.github.io/elixir-workshop
https://github.com/paweljw/elixir-workshop

---

# [APLAUZ]
