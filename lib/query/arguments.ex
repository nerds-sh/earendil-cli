defmodule EarendilCli.Query.Arguments do
  alias EarendilCli.Deployment.ContractAgent, as: Contract

  defp add_step_args(%{arguments: step_args}, args) do
    if not is_nil(step_args), do: args ++ ["--arguments=#{step_args}"], else: args
  end

  def make(task) do
    args = [
      "--verbose",
      "contract",
      "query",
      Contract.get(),
      "--function=#{task.function}",
    ]

    args = add_step_args(task, args)

    args ++ [
      "--proxy=#{task.config.proxy}",
    ]
  end
end
