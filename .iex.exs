IEx.configure(
  alive_prompt: "%prefix(%node):%counter>",
  colors: [eval_result: [:green]],
  default_prompt: "%prefix:%counter>",
  inspect: [pretty: true, charlists: :as_lists],
)

defmodule EctoHelpers do
  defmacro __using__(_) do
    quote do
      IO.puts "\nimporting:\n  Ecto.Query.{ limit, select, where }\n  Ecto.Query.API.{ fragment }\n"
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
