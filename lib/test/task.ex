alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Test.Model, as: Model
alias EarendilCli.Test.Context, as: Context

defimpl Protocol, for: Model do
  import EarendilCli.Common.Utils

  defp make_env() do
    alias EarendilCli.Common.Context, as: Context

    __ENV__
  end

  def run(task) do
    ExUnit.start()
    content = Code.string_to_quoted(read_file(task.path, :relative))
    Module.create(TestModule, content, make_env())
  end
end
