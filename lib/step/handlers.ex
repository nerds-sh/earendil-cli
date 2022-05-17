defmodule Earendil.Step.Handlers do
  alias Earendil.Protocols.Task, as: Task
  alias Earendil.Deployment.Model, as: Deployment
  alias Earendil.Transaction.Model, as: Transaction
  alias Earendil.Query.Model, as: Query
  alias Earendil.Test.Model, as: Test

  defp run(model, options), do: Task.run(struct(model, options))

  def handle_step(%{type: "deploy"} = step), do: run(Deployment, step.options)

  def handle_step(%{type: "transaction"} = step), do: run(Transaction, step.options)

  def handle_step(%{type: "query"} = step), do: run(Query, step.options)

  def handle_step(%{type: "test"} = step), do: run(Test, step.options)
end
