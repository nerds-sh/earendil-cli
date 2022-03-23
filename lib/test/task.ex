alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Test.Model, as: Model
alias EarendilCli.Test.Context, as: Context

defimpl Protocol, for: Model do
  import EarendilCli.Common.Utils

  defp make_env() do
    alias EarendilCli.Test.Context, as: Context

    __ENV__
  end

  def run(task) do
    ExUnit.start()
    Context.set(task.config)
    content = Code.string_to_quoted(read_file(task.path))
    Module.create(TestModule, content, make_env())
  end
end
