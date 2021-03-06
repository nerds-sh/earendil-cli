defmodule Earendil.Transaction.Arguments do
  alias Earendil.Deployment.ContractAgent, as: Contract
  alias Earendil.Common.Path, as: RelativePath
  alias Earendil.Config.Agent, as: Config

  defp add_arguments(args, %{arguments: arguments}) do
    if not is_nil(arguments), do: args ++ ["--arguments=#{arguments}"], else: args
  end

  defp add_value(args, %{value: value}) do
    if not is_nil(value), do: args ++ ["--value=#{value}"], else: args
  end

  defp add_step_args(task, args) do
    args
    |> add_arguments(task)
    |> add_value(task)
  end

  def make(task) do
    config = Config.get()

    args = [
      "contract",
      "call",
      Contract.get().address,
      "--function=#{task.function}"
    ]

    args = add_step_args(task, args)

    args ++
      [
        "--gas-limit=#{task.gas_limit}",
        "--proxy=#{config.proxy}",
        "--recall-nonce",
        "--send",
        "--chain=#{config.chain}",
        "--pem=#{RelativePath.expand(config.pem)}"
      ]
  end
end
