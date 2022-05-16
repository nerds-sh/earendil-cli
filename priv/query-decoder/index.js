const {decode} = require('@nerds.sh/elrond-decoder')

const makeInput = args => ({
    abi: {
        type: 'file',
        value: args[0]
    },
    contract: args[1],
    environment: args[2],
    func: args[3],
})

const decodeQuery = () => {
    const [_, __, ...args] = process.argv

    return decode(makeInput(args))
}

decodeQuery()
    .then(JSON.stringify)
    .then(console.log)
