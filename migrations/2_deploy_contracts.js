const Whitelist = artifacts.require("./Whitelist.sol");
const EuroClaimTokenContract = artifacts.require("./EuroClaimTokenContract.sol");
const BondsContract = artifacts.require("./BondsContract.sol");

module.exports = async function(deployer) {
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
        return euroToken = deployer.deploy(EuroClaimTokenContract, bonds.address);
      }).then(euroToken => {
        console.log("euro token contract address: " + euroToken.address);
      })
};
