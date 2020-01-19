const Whitelist = artifacts.require("./Whitelist.sol");
const EuroClaimTokenContract = artifacts.require("./EuroClaimTokenContract.sol");
const BondsContract = artifacts.require("./BondsContract.sol");

module.exports = function(deployer) {
    let doc = "";
    let maxSupplyCap = 50000000;
    let minPurchaseAmount = 1000;

    let wl = await deployer.deploy(Whitelist);

    console.log("whitelist deployed:");
    console.log(wl);
    console.log(wl.address);

    bonds = deployer.deploy(BondsContract, wl.address, doc, maxSupplyCap, minPurchaseAmount);
    euroToken = deployer.deploy(EuroClaimTokenContract);

    // Whitelist whitelist, uint256 document, uint256 maxSupplyCap, uint256 minPurchaseAmount
};
