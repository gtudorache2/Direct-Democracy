const HDWalletProvider = require("truffle-hdwallet-provider");
const MNEMONIC = "help comic you pear step error better abuse few exact rabbit twin";
module.exports = {
  compilers: {
    solc: {
      version: "0.8.19"
    }
  },
  networks: {
    development: {
      provider: new HDWalletProvider(MNEMONIC, 'http://127.0.0.1:8545', 1),
      network_id: "*"
    },
    loc_development_development: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    }
  }
};
