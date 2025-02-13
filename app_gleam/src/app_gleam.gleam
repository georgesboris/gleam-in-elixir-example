import gleam/option

pub type User {
  User(name: String, email: String, last_seen_at: option.Option(Int))
}

pub fn hello() {
  "Hello from Gleam!"
}

pub fn new_user(name, email, last_seen_at) {
  User(name:, email:, last_seen_at: option.Some(last_seen_at))
}
