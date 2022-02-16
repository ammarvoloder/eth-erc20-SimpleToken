const SimpleToken = artifacts.require("SimpleToken");
const SafeMath = artifacts.require("SafeMath");

module.exports = function (deployer) {
    deployer.deploy(SafeMath);
    deployer.link(SafeMath, SimpleToken);
    const totalSupply = 100;
    deployer.deploy(SimpleToken, totalSupply);
};