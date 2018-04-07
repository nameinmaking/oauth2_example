defmodule Oauth2Example.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :token, :string

      timestamps()
    end

  end
end
