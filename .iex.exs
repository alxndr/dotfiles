IEx.configure(
  alive_prompt: "%prefix(%node):%counter>",
  colors: [eval_result: [:green]],
  default_prompt: "%prefix:%counter>",
  inspect: [limit: -1],
)

defmodule EctoHelpers do
  defmacro __using__(_) do
    quote do
      IO.puts "importing Ecto.Query.{limit, select, where} and Ecto.Query.API.fragment"
      import Ecto.Query, only: [limit: 2, select: 3, where: 3]
      import Ecto.Query.API, only: [fragment: 1]
      :ok
    end
  end
end

case Code.ensure_loaded(Ecto) do
  {:module, _} -> IO.puts "\nEcto detected... get helpers in scope:\n> use EctoHelpers\n"
  {:error,  _} -> nil
end
