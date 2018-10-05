const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');

const compiledHistory = require('./build/History.json');

const secretValue = require('./secret.json');
const provider = new HDWalletProvider(
    secretValue.mnemonic,
    secretValue.provider_url
);

const web3 = new Web3(provider);

const deploy = async() => {
    const accounts = await web3.eth.getAccounts();

    console.log("Attempting to deploy contract from account: ", accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(compiledHistory.interface))
        .deploy({ data: compiledHistory.bytecode })
        .send({ from: accounts[0], gas: '1000000' });

    console.log("Contract deployed to: ", result.options.address);
};
deploy();