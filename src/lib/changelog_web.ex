defmodule ChangelogWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: ChangelogWeb

      alias Changelog.Repo
      alias ChangelogWeb.Plug.{RequireAdmin, RequireUser, RequireGuest}
      import Ecto
      import Ecto.Query

      import ChangelogWeb.Router.Helpers
      import ChangelogWeb.Plug.Conn

      defp is_admin?(user = %Changelog.Person{}), do: user.admin
      defp is_admin?(_), do: false

      defp redirect_next(conn, %{"next" => ""}, fallback), do: redirect(conn, to: fallback)
      defp redirect_next(conn, %{"next" => next}, _fallback), do: redirect(conn, to: next)
      defp redirect_next(conn, _next, fallback), do: redirect(conn, to: fallback)
    end
  end

  def admin_view do
    quote do
      use Phoenix.View, root: "lib/changelog_web/templates", namespace: ChangelogWeb
      use Phoenix.HTML
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 1,get_flash: 2, view_module: 1]
      import Scrivener.HTML
      import ChangelogWeb.Router.Helpers
      import ChangelogWeb.Helpers.{AdminHelpers, SharedHelpers}
      alias ChangelogWeb.TimeView
    end
  end

  def public_view do
    quote do
      use Phoenix.View, root: "lib/changelog_web/templates", namespace: ChangelogWeb, pattern: "**/*"
      use Phoenix.HTML
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 1,get_flash: 2, view_module: 1]
      import ChangelogWeb.Router.Helpers
      import ChangelogWeb.Helpers.{PublicHelpers, SharedHelpers}
      alias ChangelogWeb.{SharedView, TimeView}
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Changelog.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
