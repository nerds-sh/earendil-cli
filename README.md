# The Earendil Cli
Cli app written in Elixir to ease the interaction with Elrond Smart Contracts

## Dependencies
* `python3` - installed and added to the path
* `pip3` - installed and added to the path
* `git` - installed and added to the path

## Installation
```sh
curl https://raw.githubusercontent.com/nerds-sh/earendil-cli/master/install.sh | sh
```
> Note: Windows is not (and will not be) supported

## Dev Requirements
* `erdpy` - installed and added to the path
* `erlang` - installed and added to the path
* `elixir` - installed and added to the path

## Running locally 
* Clone this repository
* Run `mix deps.get`
* Run `mix earendil run <path_to_steps_json>`

## Steps 
The steps that are to be run are to be defined inside a json file. Here's an example of how one such file might look like:
```json
{
	"config": {
		"pem": "~/devnet-wallet.pem",
		"proxy": "https://testnet-api.elrond.com",
		"chain": "T"
	},
	"steps": [
		{
			"type": "deploy",
			"options": {
				"path": "~/src/nerds/carpathian/raffle",
				"arguments": "0x0000000000000000000100000000000000000000000000000000000010ffffff",
				"gas_limit": 600000000,
				"delay": 10000
			}
		},
		{
			"type": "transaction",
			"options": {
				"gas_limit": 20000000,
				"function": "pause",
				"delay": 10000
			}
		},
		{
			"type": "transaction",
			"options": {
				"arguments": "0x623a315b",
				"gas_limit": 20000000,
				"function": "setNewDeadline",
				"delay": 10000
			}
		},
		{
			"type": "transaction",
			"options": {
				"gas_limit": 20000000,
				"function": "unpause",
				"delay": 10000
			}
    	},
		{
			"type": "query",
			"options": {
				"function": "getWinners"
			}
		},
		{
			"type": "test",
			"options": {
				"path": "~/test-module.ex"
			}
		}
	]
}
```

## Tests
Using a `test` step allows writing custom tests using [ExUnit]("https://hexdocs.pm/ex_unit/1.12/ExUnit.html"). Getting the context can be done using the `Context.get()` function, with the `Context` module being injected at runtime. An example test could look like this:
```elixir
defmodule TestModule do
  use ExUnit.Case

	test "Proxy is correct" do
		assert Context.get()[:proxy] == "https://testnet-api.elrond.com"
	end

	test "Chain id is correct" do
		assert Context.get()[:chain] == "T"
	end
end
```