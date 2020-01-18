const BondsContract = artifacts.require("./BondsContract.sol");

module.exports = function(deployer) {
    deployer.deploy(BondsContract);
};
