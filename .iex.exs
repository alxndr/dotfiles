IEx.configure(
  alive_prompt: "%prefix(%node):%counter>",
  colors: [eval_result: [:green]],
  default_prompt: "%prefix:%counter>",
  inspect: [limit: -1],
)

if Ecto.Query do
  import Ecto.Query, only: [limit: 2, select: 3, where: 3]
end
