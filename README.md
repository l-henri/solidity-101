# Solidity-101
## Introduction
Welcome! This is an automated workshop that will on using Solidity Smart contracts. It is aimed at developers who are not familiar with Solidity, or smart contracts.


## How to work on this TD
### Introduction
The workshop has two components:
- An ERC20 token, ticker `TD-SOL-101`, that is used to keep track of points 
- A set of 15 exercises that are able to mint and distribute TD-SOL-101 points

Your objective is to gather as many TD-SOL-101 points as possible. Please note :
- You will need testnet Ether to do this workshop. Lookup "Sepolia testnet faucet" on google.
- The 'transfer' function of TD-SOL-101 has been disabled to encourage you to finish the TD with only one address


### Getting to work
- The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). 
- Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students and credit points
- Each exercice is deployed on the Sepolia testnet. You can interact with them through [MyCrypto](https://mycrypto.com/contracts/interact), using the contract ABIs in [this folder](build/contracts), or through etherscan.
- In order to receive points, you will have to call function that execute code in each smart contract,  such that the function `creditStudent(n, msg.sender);` is triggered, and distributes n points.
- A low level description of what is expected can be inferred by reading the code in each exercice.

## Exercises addresses
|Topic|Contract code|Contract on Etherscan|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://sepolia.etherscan.io/address/0x70303CfE4636F18F6689Da1Ea5E58C092151a63D)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://sepolia.etherscan.io/address/0x7528C397b0743D9912C1308EF925A4Cc0738c705)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://sepolia.etherscan.io/address/0x354B89a92df925b9FB2C9f930c871f61cF7C6a4b)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://sepolia.etherscan.io/address/0xCBEb615aA19830249686C7543A0919eAC8bE591c)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://sepolia.etherscan.io/address/0x80A430cee2A26D1afDe56d18e8FFd2cA0e8BAe2E)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://sepolia.etherscan.io/address/0xE11fb6d8a9F973ae22146711A216D19c679391aa)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://sepolia.etherscan.io/address/0x43713B93B5358aDEbA43B0d30df8ACd9B358d877)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://sepolia.etherscan.io/address/0xCC13c89162F23d7Fc5EA008b71D53E7F49666d04)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://sepolia.etherscan.io/address/0xC2746B4516a8d4651BEe6dA1C4821302F97584a5)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://sepolia.etherscan.io/address/0xdA2cE5fF69CfDF274fCB5ABd32A138816f82564b)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://sepolia.etherscan.io/address/0xFe9a68470f54b32078487EF7dfBf705307e37221)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://sepolia.etherscan.io/address/0x345239268fB5A4E485a43E10A2c7336B0f9a2d75)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|
|Deploy your contract to validate exercices|[Ex14](contracts/exercices/ex14.sol)|[Link](https://sepolia.etherscan.io/address/0x12b4A5e38BAdA1B1990bf5D124363f00C33Fa54B)|
|All in one!|[Ex15](contracts/exercices/ex15.sol)|[Link](https://sepolia.etherscan.io/address/0xF7De3b14872Ef5926EeC0f4e9914D832aD2f9394)|



