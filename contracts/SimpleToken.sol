// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./interfaces/IERC20.sol";
import "./libraries/SafeMath.sol";

contract SimpleToken is IERC20 {

    using SafeMath for uint256;

    string public constant name = "SimpleToken";
    string public constant symbol = "STK";
    uint8 public constant decimals = 18;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    uint256 _totalSupply;

    constructor (uint256 total) {
        _totalSupply = total;
        balances[msg.sender] = _totalSupply;    
    }

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public override view returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(amount <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[recipient] = balances[recipient].add(amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public override view returns (uint256) {
        return allowed[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
        ) 
        public
        override 
        returns (bool) 
        {
            require(amount <= balances[sender]);
            require(amount <= allowed[sender][msg.sender]);

            balances[sender] = balances[sender].sub(amount);
            allowed[sender][msg.sender] = allowed[sender][msg.sender].sub(amount);
            balances[recipient] = balances[recipient].add(amount);
            emit Transfer(sender, recipient, amount);
            return true;
        }
}