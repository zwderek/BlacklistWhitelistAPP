const MyContract = artifacts.require("Token");

module.exports = function(deployer, network) {
  
    deployer.deploy(MyContract, 1, 100000);

};
