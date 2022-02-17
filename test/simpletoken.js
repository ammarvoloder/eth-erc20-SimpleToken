const SimpleToken = artifacts.require("SimpleToken");

contract("SimpleToken", accounts => {

   it("should have a total supply of 100 simple tokens", function(){
       return SimpleToken.deployed().then(function(instance){
            return instance.totalSupply.call()
       }).then(function(supply){
           assert.equal(supply.valueOf(), 100, "Total supply is not 100 tokens")
       });
   });

   it("should put 100 Simple Token into the first account", function(){
       return SimpleToken.deployed().then(function(instance){
           return instance.balanceOf.call(accounts[0])
       }).then(function(balance){
           assert.equal(balance.valueOf(), 100, "The account is not filled with 100 tokens");
       });
   });

   it("should check the balance of the second account", function(){
    return SimpleToken.deployed().then(function(instance){
        return instance.balanceOf.call(accounts[1])
        }).then(function(balance){
            assert.equal(balance.valueOf(), 0, "The account is not empty");
        });
    });

    it("should sent 30 simple tokens to another account", async function(){
        const instance = await SimpleToken.deployed();
        await instance.transfer(accounts[1], 30);

        const balanceAccount0 = await instance.balanceOf(accounts[0]);
        const balanceAccount1 = await instance.balanceOf(accounts[1]);

        assert.equal(balanceAccount0.valueOf(), 70, "The transfer was not successfull. The amount was not correctly substracted");
        assert.equal(balanceAccount1.valueOf(), 30, "The transfer was not successfull. The amount was not correctly transferred");
    });

});