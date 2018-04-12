defmodule ChangelogWeb.Helpers.SharedHelpers do
  use Phoenix.HTML

  alias Changelog.Regexp
  alias Phoenix.{Controller, Naming}

  def active_class(conn, controllers, class_name \\ "is-active")
  def active_class(conn, controllers, class_name) when is_binary(controllers), do: active_class(conn, [controllers], class_name)
  def active_class(conn, controllers, class_name) when is_list(controllers) do
    active_id = controller_action_combo(conn)

    if Enum.any?(controllers, fn(x) -> String.match?(active_id, ~r/#{x}/) end) do
      class_name
    end
  end

  def action_name(conn), do: Controller.action_name(conn)

  def comma_separated(number) do
    number
    |> Integer.to_charlist
    |> Enum.reverse
    |> Enum.chunk(3, 3, [])
    |> Enum.join(",")
    |> String.reverse
  end

  def controller_name(conn), do: Controller.controller_module(conn) |> Naming.resource_name("Controller")
  def controller_action_combo(conn), do: [controller_name(conn), action_name(conn)] |> Enum.join("-")
  def controller_action_combo_matches?(conn, list) when is_list(list) do
    combo = controller_action_combo(conn)
    Enum.any?(list, &(&1 == combo))
  end

  def ctr(%{impression_count: 0}), do: 0
  def ctr(%{click_count: 0}), do: 0
  def ctr(trackable) do
    Float.round(trackable.click_count / trackable.impression_count * 100, 1)
  end

  def current_path(conn), do: Controller.current_path(conn)
  def current_path(conn, params), do: Controller.current_path(conn, params)

  def dev_relative(url), do: if Mix.env == :dev, do: URI.parse(url).path, else: url

  def domain_name(url) do
    uri = URI.parse(url)
    uri.host
  end

  def domain_url(url) do
    uri = URI.parse(url)
    "#{uri.scheme}://#{uri.host}"
  end

  def external_link(text, opts) do
    link text, (opts ++ [rel: "external"])
  end

  def get_param(conn, param, default \\ nil), do: Map.get(conn.params, param, default)
  def get_assigns_or_param(conn, param, default \\ nil) do
    Map.get(conn.assigns, String.to_atom(param)) || get_param(conn, param, default)
  end

  def github_url(handle), do: "https://github.com/#{handle}"

  def github_link(model) do
    if model.github_handle do
      external_link model.github_handle, to: github_url(model.github_handle)
    end
  end

  def md_to_safe_html(md) when is_binary(md), do: Cmark.to_html(md, [:safe])
  def md_to_safe_html(md) when is_nil(md), do: ""

  def md_to_html(md) when is_binary(md), do: Cmark.to_html(md)
  def md_to_html(md) when is_nil(md), do: ""

  def md_to_text(md) when is_binary(md), do: md |> md_to_html |> HtmlSanitizeEx.strip_tags |> sans_new_lines
  def md_to_text(md) when is_nil(md), do: ""

  def sans_p_tags(html), do: String.replace(html, Regexp.tag("p"), "")

  def sans_new_lines(string), do: String.replace(string, "\n", " ")

  def truncate(string, length) when is_binary(string) do
    if String.length(string) > length do
      String.slice(string, 0, length) <> "..."
    else
      string
    end
  end
  def truncate(_string, _length), do: ""

  def twitter_url(nil), do: nil
  def twitter_url(handle) when is_binary(handle), do: "https://twitter.com/#{handle}"
  def twitter_url(person), do: "https://twitter.com/#{person.twitter_handle}"

  def twitter_link(model, string \\ nil) do
    if model.twitter_handle do
      external_link((string || model.twitter_handle), to: twitter_url(model.twitter_handle))
    end
  end

  def website_link(model) do
    if model.website do
      external_link domain_name(model.website), to: model.website
    end
  end

  def word_count(nil), do: 0
  def word_count(text) when is_binary(text) do
    text |> md_to_text |> String.split |> length
  end

  def pluralize(list, singular, plural) when is_list(list), do: pluralize(length(list), singular, plural)
  def pluralize(1, singular, _plural), do: "1 #{singular}"
  def pluralize(count, _singular, plural), do: "#{count} #{plural}"
end
