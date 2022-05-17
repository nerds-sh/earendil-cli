alias Earendil.Protocols.Task, as: Protocol
alias Earendil.Test.Model, as: Model
alias Earendil.Test.Context, as: Context

defimpl Protocol, for: Model do
  import Earendil.Common.Utils

  defp make_env() do
    alias Earendil.Common.Context, as: Context

    __ENV__
  end

  def run(task) do
    ExUnit.start()
    content = Code.string_to_quoted(read_file(task.path, :relative))
    Module.create(TestModule, content, make_env())
  end
end
