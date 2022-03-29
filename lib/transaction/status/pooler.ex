defmodule EarendilCli.Transaction.Status.Pooler do
  import ShorterMaps
  alias EarendilCli.Transaction.Status.Getter, as: Getter
  alias EarendilCli.Common.Utils, as: Utils

  defp repeat(function) do
    Utils.apply_delay(~M{delay: 2000})

    pool(function)
  end

  def pool(function) do
    transaction = Getter.get(function)

    case transaction.status do
      "pending" ->
        repeat(function)

      _ ->
        transaction
    end
  end
end
