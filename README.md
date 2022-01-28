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
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://rinkeby.etherscan.io/contract/0x685620EFBeCE50A84F48e6bf8b87312F07bB9c23)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://rinkeby.etherscan.io/contract/0x6ec8B610359C13A2e337d83a5cD60df09541A45A)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://rinkeby.etherscan.io/contract/0x057eb8BF95620F429eEcD03BCE390861995ab05C)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://rinkeby.etherscan.io/contract/0x6aD0cb1d8E00D8d4cDB46198411a43e5683f5550)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://rinkeby.etherscan.io/contract/0x39D7511fB9f12bC99A1d1225eed17B2293C59f85)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://rinkeby.etherscan.io/contract/0x333bCe26713A36D02aabCBd94927e4E7FBE8C2A9)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://rinkeby.etherscan.io/contract/0xaB1DF75053F36AAabD88166Fc6F1080B5a47c4C7)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://rinkeby.etherscan.io/contract/0x9D3241b6bFeEcE7Abc233072aDa18e17Ec1eD948)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://rinkeby.etherscan.io/contract/0xb595b4ddb362aB4804F58aC222D7489DEC1CcCfe)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://rinkeby.etherscan.io/contract/0x5a4E2eE5AF05e0FB648A0f0bb5BF7FAe5fc2F657)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://rinkeby.etherscan.io/contract/0x892ba594CFB0c2176c14d8DBb8A76a68A17fBF5D)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://rinkeby.etherscan.io/contract/0xB1737787022cE2Cb0C415F660a527a4480acC4ea)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|



