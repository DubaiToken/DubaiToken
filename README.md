
# DubaiToken(DXB) Smart Contracts
<img hight="180" width="180" alt="current" src="./assets/dubaiToken.jpg">

[![yarn](https://img.shields.io/badge/yarn-v1.6.0-yellow.svg)](https://yarnpkg.com/lang/en/docs/install/)
[![npm](https://img.shields.io/npm/v/npm.svg)](https://github.com/nodejs/node)
[![truffle](https://img.shields.io/badge/truffle-docs-orange.svg)](http://truffleframework.com/docs/)
[![ganache-cli](https://img.shields.io/badge/ganache-cli-yellowgreen.svg)](http://truffleframework.com/ganache/)
[![solidity](https://img.shields.io/badge/solidity-docs-red.svg)](https://solidity.readthedocs.io/en/develop/)

## Project description
The World's First Hotels Reservations Crypto-Payments Service Token.

This repository contains the Dubai token smart-contract.

## Contract Specification

ERC20 is an official protocol for proposing improvements to the Ethereum (ETH) network. 
ERC stands for Ethereum Request for Comment, and 20 is the proposal identifier

### ERC20 Token

The public interface of PAX Standard is the ERC20 interface
specified by [EIP-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md).

- `name()`
- `symbol()`
- `decimals()`
- `totalSupply()`
- `balanceOf(address who)`
- `transfer(address to, uint256 value)`
- `approve(address spender, uint256 value)`
- `allowance(address owner, address spender)`
- `transferFrom(address from, address to, uint256 value)`

And the usual events.

- `event Transfer(address indexed from, address indexed to, uint256 value)`
- `event Approval(address indexed owner, address indexed spender, uint256 value)`

Typical interaction with the contract will use `transfer` to move the token as payment.
Additionally, a pattern involving `approve` and `transferFrom` can be used to allow another 
address to move tokens from your address to a third party without the need for the middleperson 
to custody the tokens, such as in the 0x protocol. 

### Pausing the contract

In the event of a critical security threat, ERC20 has the ability to pause transfers
and approvals of the token. The ability to pause is controlled by a single `owner` role,
 following OpenZeppelin's
[Ownable](https://github.com/OpenZeppelin/openzeppelin-solidity/blob/5daaf60d11ee2075260d0f3adfb22b1c536db983/contracts/ownership/Ownable.sol). 
The simple model for pausing transfers following OpenZeppelin's
[Pausable](https://github.com/OpenZeppelin/openzeppelin-solidity/blob/5daaf60d11ee2075260d0f3adfb22b1c536db983/contracts/lifecycle/Pausable.sol).

## Contract verification

The proxy contract and implementation contracts are verified on etherscan at the following links:
https://etherscan.io/token/0x83de61115b819601d4a44fa02f7d6642f6346013

<!--
**DubaiToken/DubaiToken** is a ✨ _special_ ✨ repository because its `README.md` (this file) appears on your GitHub profile.



Here are some ideas to get you started:

- 🔭 I’m currently working on ...
- 🌱 I’m currently learning ...
- 👯 I’m looking to collaborate on ...
- 🤔 I’m looking for help with ...
- 💬 Ask me about ...
- 📫 How to reach me: ...
- 😄 Pronouns: ...
- ⚡ Fun fact: ...
-->
