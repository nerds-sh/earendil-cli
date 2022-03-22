# The Earendil Cli
Cli app written in Elixir to ease the interaction with Elrond Smart Contracts

## Requirements
* `erdpy` - installed and added to the path
* `erlang` - installed and added to the path
* `elixir` - installed and added to the path

## Running
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
		}
	]
}
```