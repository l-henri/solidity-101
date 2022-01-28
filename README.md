# Solidity-101
## Introduction
Welcome! This is an automated workshop that will on using Solidity Smart contracts. It is aimed at developers who are not familiar with Solidity, or smart contracts.


## How to work on this TD
### Introduction
The workshop has two components:
- An ERC20 token, ticker TD-SOL-101, that is used to keep track of points 
- A set of 12 exercises that are able to mint and distribute TD-SOL-101 points

Your objective is to gather as many TD-SOL-101 points as possible. Please note :
- You will need testnet Ether to do this workshop. Lookup "rinkeby testnet faucet" on google.
- The 'transfer' function of TD-SOL-101 has been disabled to encourage you to finish the TD with only one address


### Getting to work
- The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). 
- Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students and credit points
- Each exercice is deployed on the Rinkeby testnet. You can interact with them through [MyCrypto](https://mycrypto.com/contracts/interact), using the contract ABIs in [this folder](build/contracts), or through etherscan.
- In order to receive points, you will have to call function that execute code in each smart contract,  such that the function `creditStudent(n, msg.sender);` is triggered, and distributes n points.
- A low level description of what is expected can be inferred by reading the code in each exercice.

## Exercises addresses
* "0x173cfbcc3fdbfCCa2A90511FE7B9ca425564C983",  // [Points manager](contracts/ERC20TD.sol)
* "0xbe7e5b95Bad8F304efbD9510EEe3382702AA411c",  // [Ex1Contract](contracts/exercices/ex01.sol)
* "0x78Cab5B8765c2E713e6364f0052b570fa01b2e7D",  // [Ex2Contract](contracts/exercices/ex02.sol)
* "0x2E6C56DF81F1192e8D69e3C38581A780C872583b",  // [Ex3Contract](contracts/exercices/ex03.sol)
* "0x55406074F608773847a68fF9AdAa8eF475708A99",  // [Ex4Contract](contracts/exercices/ex04.sol)
* "0x3C60C427C0696cFc83a6de4D3E41694650264046",  // [Ex5Contract](contracts/exercices/ex05.sol)
* "0xA9F5f2E49F93A6eD59a24Aa5FB81097E65e20D73",  // [Ex6Contract](contracts/exercices/ex06.sol)
* "0x51330284182faEd4fBC8273711f7096fCcD60e5e",  // [Ex7Contract](contracts/exercices/ex07.sol)
* "0xeda23675c8040dcFF4A33aA74701f1388deEcc8B",  // [Ex8Contract](contracts/exercices/ex08.sol)
* "0xEDC96502Db9594c0435eBa370f0A6F64Ae5581d5",  // [Ex9Contract](contracts/exercices/ex09.sol)
* "0x291dD0D61C9F876c5e5E81115f38967410c7f7CA",  // [Ex10Contract](contracts/exercices/ex10.sol)
* "0xf1fC623176d712740c0038B59e054a9e9Fb286fA",  // [Ex11Contract](contracts/exercices/ex11.sol)
* Undisclosed // [Ex12Contract](contracts/exercices/ex12.sol)

