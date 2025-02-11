import app_gleam
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  app_gleam.hello()
  |> should.equal("Hello from Gleam!")
}
