defmodule EarendilCli.Step.Handlers do
  alias EarendilCli.Protocols.Task, as: Task
  alias EarendilCli.Deployment.Model, as: Deployment
  alias EarendilCli.Transaction.Model, as: Transaction
  alias EarendilCli.Query.Model, as: Query
  alias EarendilCli.Test.Model, as: Test

  defp run(model, options), do: Task.run(struct(model, options))

  def handle_step(%{type: "deploy"} = step), do: run(Deployment, step.options)

  def handle_step(%{type: "transaction"} = step), do: run(Transaction, step.options)

  def handle_step(%{type: "query"} = step), do: run(Query, step.options)

  def handle_step(%{type: "test"} = step), do: run(Test, step.options)
end
