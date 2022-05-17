defmodule Earendil.Transaction.Status do
  alias Earendil.Transaction.Status.Getter, as: Getter
  alias Earendil.Transaction.Status.Pooler, as: Pooler

  def get(function), do: Getter.get(function)
  def pool(function), do: Pooler.pool(function)
end
