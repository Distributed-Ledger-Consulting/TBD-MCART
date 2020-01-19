const Whitelist = artifacts.require("./Whitelist.sol");
const EuroClaimTokenContract = artifacts.require("./EuroClaimTokenContract.sol");
const BondsContract = artifacts.require("./BondsContract.sol");

module.exports = async function(deployer, network, accounts) {
    let doc = "";
    let maxSupplyCap = 50000000;
    let minPurchaseAmount = 1000;

    deployer.deploy(Whitelist)
      .then(wl => {
        console.log("deploy BondsContract");
        return deployer.deploy(BondsContract, wl.address, doc, maxSupplyCap, minPurchaseAmount);
      })
      .then(bonds => {
        console.log("deploy EuroToken");
        return [bonds, euroToken = deployer.deploy(EuroClaimTokenContract, bonds.address)];
      }).then(v => {
        console.log("setting euro token contract address on bonds: " + v[1].address);
        acc0 = accounts[0];
        v[0].setClaimTokenAddress(v[1].address, { from: acc0, value: 1, gas: 3000000 });
      })
};
