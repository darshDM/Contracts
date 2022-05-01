//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;
/*
Base Source: openzeppelin
Updated by: DarshDM
Description: Made Gas efficient by using error-revert instead of require statements
Solidity: ^0.8.7
*/
error SafeMath__MathError();
error SafeMath__DivideByZero();
error SafeMath__Underflow();

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns(uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    if(c / a != b){
        revert SafeMath__MathError();
    }

    return c;
  }

  /**
  * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    if(b < 0){// Solidity only automatically asserts when dividing by 0
        revert SafeMath__DivideByZero();
    }
    uint256 c = a / b;

    return c;
  }

  /**
  * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    if(b > a){
        revert SafeMath__Underflow();
    }
    uint256 c = a - b;

    return c;
  }

  /**
  * @dev Adds two numbers, reverts on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    if(c < a){
        revert SafeMath__MathError();
    }

    return c;
  }

  /**
  * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
  * reverts when dividing by zero.
  */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    if(b == 0){
        revert SafeMath__MathError();
    }
    return a % b;
  }
}