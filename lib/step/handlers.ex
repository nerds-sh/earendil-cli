defmodule EarendilCli.Step.Handlers do
  alias EarendilCli.Protocols.Task, as: Task
  alias EarendilCli.Deployment.Model, as: Deployment
  alias EarendilCli.Transaction.Model, as: Transaction
  alias EarendilCli.Query.Model, as: Query

  def handle_step(config, %{type: "deploy"} = step) do
    parameter = Map.put(step.options, :config, config)

    Task.run(struct(Deployment, parameter))
  end

  def handle_step(config, %{type: "transaction"} = step) do
    parameter = Map.put(step.options, :config, config)

    Task.run(struct(Transaction, parameter))
  end

  def handle_step(config, %{type: "query"} = step) do
    parameter = Map.put(step.options, :config, config)

    Task.run(struct(Query, parameter))
  end
end
