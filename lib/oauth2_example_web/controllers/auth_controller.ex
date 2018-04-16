defmodule Oauth2ExampleWeb.AuthController do
  use Oauth2ExampleWeb, :controller
  plug Ueberauth
  alias Oauth2Example.Accounts.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    # IO.puts "++++++"
    # IO.inspect(conn.assigns)
    # IO.puts "++++++"
    # IO.inspect(params)
    # IO.puts "++++++"
    # IO.inspect(auth)
    # Create a new changeset and insert data into the DB
    user_params = %{token: auth.credentials.tokens, email: auth.info.email, provider: "github"}
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Erro signing in")
        |> redirect(to: user_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    # changes is a property of changeset
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user} #adding :ok atom as for insert we are returned a tuple
    end
  end
end
