defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "gustavocvalenciano@gmail.com", name: "gustavo", password: "123456"}

      {:ok, %User{id: user_id}} = Wabanex.User.Create.call(params)

      query = """
       {
        getUser(id: "#{user_id}") {
          email,
          name,
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{"email" => "gustavocvalenciano@gmail.com", "name" => "gustavo"}
        }
      }

      assert response == expected_response
    end
  end
end
