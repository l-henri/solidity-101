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
|Topic|Contract code|Contract on Etherscan|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://rinkeby.etherscan.io/contract/0xEc2Ab930eAd292f524832290d449FE292058d138)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://rinkeby.etherscan.io/contract/0xD77c27E49df066D7AbEEbC59D86EFae52f12a1c7)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://rinkeby.etherscan.io/contract/0x5D0470568C33D5543F8c5877CF4F4bfd28AC7e17)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://rinkeby.etherscan.io/contract/0x001BFb7717E4206a6EB1C64816e095bCe3832639)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://rinkeby.etherscan.io/contract/0xE8D91d3Bc8b448621780F67d97bAd9f92E646414)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://rinkeby.etherscan.io/contract/0xeccEF63874431D4410e4AEd9F846ef75044F530E)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://rinkeby.etherscan.io/contract/0x09FC33E9287031ee8F5a3E0543b4CdD74cA0bF34)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://rinkeby.etherscan.io/contract/0xF087B5a17bbf86208d394f93855BA136049a9e54)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://rinkeby.etherscan.io/contract/0xc8f409790C512F32a32d446ff40bDA2bCf8846e2)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://rinkeby.etherscan.io/contract/0xF823A770590f78eCaa2cD42aDcD5AE6B6BA69C33)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://rinkeby.etherscan.io/contract/0x743Aa9c79D1dbe031e7CE03ba37eFE9CbD204295)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://rinkeby.etherscan.io/contract/0xfac0a3D22E42492C2BF155E20af5d77C4D7E2C7F)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|



