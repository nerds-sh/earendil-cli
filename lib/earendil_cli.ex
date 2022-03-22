defmodule EarendilCli do
  import EarendilCli.Step.Parser
  use EarendilCli.Setup

  command :run do
    description "Runs a series of steps"
    long_description """
      Takes a series of steps declared in a JSON format and runs them
    """

    argument :path

    run context do
      register_supervisor()
      steps = parse(context[:path])
      run_steps(steps)
    end
  end
end

ExCLI.run(EarendilCli)
