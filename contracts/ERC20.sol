// SPDX-Lisence-Identifier: UNLICENSED
/*
Base Source: openzeppelin
Updated by: DarshDM
Description: Made Gas efficient by using error-revert instead of require statements
Solidity: ^0.8.7
*/
import "./Interface/IERC20.sol";
import "./Lib/SafeMath.sol";
pragma solidity ^0.8.7;

error ERC20__AllowanceLimitExceeded();
error ERC20__OutOfBalance();
error ERC20__InvalidAddress();

contract ERC20 is IERC20{
    using SafeMath for uint256;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;
    string public _name;
    string public _symbol;
    constructor(string name,string symbol){
        _name = name;
        _symbol = symbol;
    }
    uint256 private _totalSupply;

    function totalSupply() override external view returns(uint256){
        return _totalSupply;
    }

    function balanceOf(address account) override external view returns(uint256){
        return _balances[account];
    }

    function allowance(address owner,address spender) override external view returns(uint256){
        return _allowed[owner][spender];    
    }

    function transfer(address to, uint256 amount) override external returns(bool){
        if(amount > _balances[msg.sender]) {
            revert ERC20__OutOfBalance();
        }       
        if(address(0) == to){
            revert ERC20__InvalidAddress();
        }
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        _balances[to] = _balances[to].add(amount);

        emit Transfer(msg.sender,to,amount);
        return true;
    }

    function approve(address spender,uint256 limit) override public returns(bool){
        if(address(0) == spender){
            revert ERC20__InvalidAddress();
        }
        _allowed[msg.sender][spender] = limit;
        emit Approval(msg.sender,spender,limit);
        return true;
    }

    function transferFrom(address from,address to,uint256 amount) override external returns(bool){
        if(_balances[from] < amount){
            revert ERC20__OutOfBalance();
        }
        if(_allowed[from][msg.sender] < amount){
            revert ERC20__AllowanceLimitExceeded();
        }
        if(address(0) == to){
            revert ERC20__InvalidAddress();
        }
        _balances[from] = _balances[from].sub(amount);
        _balances[to] = _balances[to].add(amount);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(amount);
        emit Transfer(from,to,amount);
        return true;
    }

    function _mint(address account, uint256 amount) internal {
        if(account == address(0)){
            revert ERC20__InvalidAddress();
        }
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }
    
}