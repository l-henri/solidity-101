# Solidity-101
## Introduction
Welcome! This is an automated workshop that will on using Solidity Smart contracts. It is aimed at developers who are not familiar with Solidity, or smart contracts.


## How to work on this TD
### Introduction
The workshop has two components:
- An ERC20 token, ticker [TD-SOL-101](https://goerli.etherscan.io/address/0xD1d29e244C91bA16CeACBa6C9735DE9b5e54DA57), that is used to keep track of points 
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
|Points counter ERC20|[Points counter ERC20](contracts/TDERC20.sol)|[Link](https://goerli.etherscan.io/address/0xD1d29e244C91bA16CeACBa6C9735DE9b5e54DA57)|
|Calling a function|[Ex01](contracts/exercices/ex01.sol)|[Link](https://goerli.etherscan.io/address/0x6fA2b36f3751d245E8dEbe77304e46E5D9298660)|
|Payable function|[Ex02](contracts/exercices/ex02.sol)|[Link](https://goerli.etherscan.io/address/0xBeEd81F50c16F155825aeE26344b2D92e453Be42)|
|Requires|[Ex03](contracts/exercices/ex03.sol)|[Link](https://goerli.etherscan.io/address/0x502DdDb2DFEc1732A51b657C1Dc3B98CA2630722)|
|Storage variables|[Ex04](contracts/exercices/ex04.sol)|[Link](https://goerli.etherscan.io/address/0xE541Bc93a3064F71967075558e447c3C44AE9C9B)|
|Mappings|[Ex05](contracts/exercices/ex05.sol)|[Link](https://goerli.etherscan.io/address/0x2188144ebBF299E30D623378E4AB8ba203fE4244)|
|Variable visibility|[Ex06](contracts/exercices/ex06.sol)|[Link](https://goerli.etherscan.io/address/0x39BAC501B2042dD3Ef0b30C5e342e4251488b131)|
|Events|[Ex07](contracts/exercices/ex07.sol)|[Link](https://goerli.etherscan.io/address/0xD1c4744992a03aEf15a395Cd0FD9Eed17f6200F2)|
|Structures|[Ex08](contracts/exercices/ex08.sol)|[Link](https://goerli.etherscan.io/address/0x8734a14A33614Bc4A3Bd1327beEbf4559bdD1D85)|
|Code history|[Ex09](contracts/exercices/ex09.sol)|[Link](https://goerli.etherscan.io/address/0x5b45c12627Dbc946eDfd4037ac10A37363Fb1E6E)|
|Past transactions|[Ex10](contracts/exercices/ex10.sol)|[Link](https://goerli.etherscan.io/address/0x4DE3bd213b88E02542EbEa053b5E158B1609655b)|
|Composability|[Ex11](contracts/exercices/ex11.sol)|[Link](https://goerli.etherscan.io/address/0xAF59931827E33e6AD912932f7750874B0fF63fe1)|
|Blockchain forensics|[Ex12](contracts/exercices/ex12.sol)|Undisclosed|
|Deploy your contract to validate exercices|[Ex14](contracts/exercices/ex14.sol)|[Link](https://goerli.etherscan.io/address/0x4B25880211b7bde9D212486feBc55236de86789F)|
|All in one!|[Ex15](contracts/exercices/ex15.sol)|[Link](https://goerli.etherscan.io/address/0x38EB5DA6D2Ba7B2b86EF047fF11Bc2fB8558432F)|



