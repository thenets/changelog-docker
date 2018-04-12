defmodule Changelog.HashidTest do
  use ExUnit.Case

  alias Changelog.Hashid

  test "encode/decode a valid id returns the id" do
    encoded = Hashid.encode(8675309)
    assert Hashid.decode(encoded) == 8675309
  end

  test "decode an invalid id returns -1" do
    assert Hashid.decode("not_a_valid_thing") == -1
  end
end
