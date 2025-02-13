# Using Gleam with Elixir projects

![iex--S-mix](https://github.com/user-attachments/assets/d4c0738e-4add-4117-a180-60b825077279)

At [uncover.co](https://uncover.co), we had a large [Elixir](https://elixir-lang.org/) codebase but we wanted to use [Gleam](https://gleam.run/) for its type-safety on some of our core business logic. We tried to use [mix_gleam](https://github.com/gleam-lang/mix_gleam) directly but couldn't really get things to work as we wanted them to. After experimenting a bit this was a simple solution we came up with. It is not perfect, but it has been suiting us for almost a year now.

## Create and setup the Gleam project

1. Use `gleam new {gleam project name}` to create a new gleam project inside your Elixir codebase.
1. By keeping your Gleam code clearly separated from your Elixir codebase you will keep the tooling from both languages working properly.
1. Create a `mix.exs` file inside your gleam project following the example provided in this repository.
1. Whenever you add a new dependency to your gleam project, also add it manually to the mix config file.

> [!IMPORTANT]
> Your gleam test dependencies will need to be stated as regular dependencies in this mix config file, otherwise compilation will fail. This will probably be fixed sometime but AFAIK we're not there yet.

## Integrating your Gleam modules from your Elixir codebase

1. Install `mix_gleam` using `mix archive.install hex mix_gleam`.
1. Add `gleam.deps.get` as part of your `deps.get` task. This task is provided by `mix_gleam`.
1. Add your gleam project as a local dependency in your `mix.exs` file.


## Using Gleam from your Elixir codebase

You should think about your Gleam modules as libraries that you're using in your "main" application. Calling Gleam functions is not any different from calling Erlang functions.

```ex
defmodule App do
  def hello_from_gleam() do
    :app_gleam.hello()
  end
end
```

### Gleam inputs and outputs

It is completely up to you if you want to treat the boundary between your Elixir code and your Gleam code like they are isolated systems, with proper encoding/decoding from both sides. Or if you want to bypass this boundary check and just use Gleam's Erlang representation as a standard when communicating across these boundaries.

> [!NOTE]
> Calling Gleam functions from your Elixir application with no encode/decode has its risks though, especially when dealing with records, since they are represented as tuples with positional attributes. So make sure to create tests that will guarantee that if a contract fails you will catch it. Gleam's type-checking will not catch this sort of problem ahead of time since we're basically bypassing the type-checker entirely.

```gleam
// gleam/option.gleam (module from gleam's standard library)

pub fn from_result(result) {
  case result {
    Ok(a) -> Some(a)
    Error(_) -> None
  }
}

// app_gleam.gleam (your module)

pub type User {
  User(
    name: String,
    email: String,
    age: Option(Int)
  )
}

pub new_user(name, email, age) {
  User(
    name: name,
    email: email,
    age: age
  )
}

```

```ex
defmodule App do
  def gleams_basic_type_are_fine do
    assert {:some, 0} == :gleam@option.from_result({:ok, 0})
  end

  def gleams_records_are_more_risky do
    assert {:user, "User", "user@email.com", {:some, 30}} ==
      :app_gleam.new_user("User", "user@email.com", 30)
  end
end
```


