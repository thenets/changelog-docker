defmodule ChangelogWeb.Auth do
  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end
end
