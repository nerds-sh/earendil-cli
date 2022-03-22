defmodule EarendilCli.Common.Utils do
  def apply_delay(task) do
    if not is_nil(task.delay), do: :timer.sleep(task.delay)
  end
end
