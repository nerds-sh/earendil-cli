defmodule EarendilCli.Transaction.Status do
  alias EarendilCli.Transaction.Status.Getter, as: Getter
  alias EarendilCli.Transaction.Status.Pooler, as: Pooler

  def get(function), do: Getter.get(function)
  def pool(function), do: Pooler.pool(function)
end
