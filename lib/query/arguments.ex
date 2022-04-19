defmodule EarendilCli.Query.Arguments do
  alias EarendilCli.Deployment.ContractAgent, as: Contract
  alias EarendilCli.Config.Agent, as: Config

  defp add_step_args(%{arguments: step_args}, args) do
    if not is_nil(step_args), do: args ++ ["--arguments=#{step_args}"], else: args
  end

  def make(task) do
	  config = Config.get()

    args = [
      "--verbose",
      "contract",
      "query",
      Contract.get(),
      "--function=#{task.function}",
    ]

    args = add_step_args(task, args)

    args ++ [
      "--proxy=#{config.proxy}",
    ]
  end
end
