# Solidity-101
## Introduction
Welcome! This is an automated workshop that will on using Solidity Smart contracts. It is aimed at developers who are not familiar with Solidity, or smart contracts.


## How to work on this TD
### Introduction
The workshop has two components:
- An ERC20 token, ticker [TD-SOL-101](https://goerli.etherscan.io/address/0x61eCfB24Ce76B0B61D900E85719334902B95737D), that is used to keep track of points 
- A set of 12 exercises that are able to mint and distribute TD-SOL-101 points

Your objective is to gather as many TD-SOL-101 points as possible. Please note :
- You will need testnet Ether to do this workshop. Lookup "Goerli testnet faucet" on google.
- The 'transfer' function of TD-SOL-101 has been disabled to encourage you to finish the TD with only one address


### Getting to work
- The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). 
- Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students and credit points
- Each exercice is deployed on the Goerli testnet. You can interact with them through [MyCrypto](https://mycrypto.com/contracts/interact), using the contract ABIs in [this folder](build/contracts), or through etherscan.
- In order to receive points, you will have to call function that execute code in each smart contract,  such that the function `creditStudent(n, msg.sender);` is triggered, and distributes n points.
- A low level description of what is expected can be inferred by reading the code in each exercice.

## Exercises addresses
|Topic|Contract code|Contract on Etherscan|
|---|---|---|
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://goerli.etherscan.io/address/0x61eCfB24Ce76B0B61D900E85719334902B95737D)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://goerli.etherscan.io/address/0x101769BcE8978CD31F4e602eda7F7Fce27dB771e)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://goerli.etherscan.io/address/0x6dDdd446701759fa8BA3597bE9A9E01FF5691b8b)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://goerli.etherscan.io/address/0xDD99B361ff42adffA8399CCf9EbCa6b03EF374A1)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://goerli.etherscan.io/address/0xB70B0add66f7D889E8d2235FFba3934039A4A4b6)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://goerli.etherscan.io/address/0x4a363FC39c594C97D19D70A8511eD1C0334AE77e)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://goerli.etherscan.io/address/0xB4e89746B7Ba2A781b7160f435D361140c230185)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://goerli.etherscan.io/address/0x37531680e552ba80604750C2A0cCe7C57f94C6f2)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://goerli.etherscan.io/address/0xeD89a2F4771E3A9d6D0C49A9Eb595e4a9A169D40)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://goerli.etherscan.io/address/0x7A34779e9a8E3621ef035EA4678A18c8A9De3621)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://goerli.etherscan.io/address/0x1499C24FbfB3BE0f8f84E1FAa0539849362cB2bF)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://goerli.etherscan.io/address/0xB34423173F36223C397ffAa5Bd13c2FaD5b5F82f)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|



