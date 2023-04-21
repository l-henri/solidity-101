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
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://sepolia.etherscan.io/address/0x242E30987Adb4902Ae74bDc28E930F2FB2ca3956)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://sepolia.etherscan.io/address/0x5094256ad5a7aBC4772df0E1C8EeC6e86e26C939)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://sepolia.etherscan.io/address/0x5Ab1c87930fA612747bD87069186e8806b1844a5)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://sepolia.etherscan.io/address/0x850e610483107768484016e954348E808763873e)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://sepolia.etherscan.io/address/0xD80343145D924C93b4786F1878772cFd02348327)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://sepolia.etherscan.io/address/0xd177a931687Ea8624f5a63010ea45a954C6EC670)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://sepolia.etherscan.io/address/0x88ebFf0F779e885664A363029B99edE406D84a14)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://sepolia.etherscan.io/address/0x41557D2817106aE93f4054113Aa1ECE743a90572)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://sepolia.etherscan.io/address/0xD0B2D369A363624849A903015be1e04Fcd45d984)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://sepolia.etherscan.io/address/0x7BeF266B70dF419446380083aDB684B4c357Dad8)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://sepolia.etherscan.io/address/0x1b36B1c104cC32F78181689c348B36c4bc8c3CAb)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://sepolia.etherscan.io/address/0x81ECb327332A73de0665d9D9Fd6Aca53F6CeD6A1)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|
|Deploy your contract to validate exercices|[Ex14](contracts/exercices/ex14.sol)|[Link](https://sepolia.etherscan.io/address/0xABA4d8219fa64EA9f8883a53731102010daD9e55)|
|All in one!|[Ex15](contracts/exercices/ex15.sol)|[Link](https://sepolia.etherscan.io/address/0x48485De9E2346F44c3451a76eC9ab18f54787315)|



