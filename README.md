# solidity-101
A practice course on using Solidity Smart contracts.

This practice session has 11 exercices. The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students, credit points, and identify students using the [Kelsen](https://github.com/97network/Kelsen) framework.

Points are managed through the [pointManager](contracts/pointsManager.sol) contract. For the moment, only registered students can participate in the exercice. However, if you want to take a shot at the exercices, reach out to henri.lieutaud [at] ext.devinci.fr. The whole exam might be fully opened in the future.

You can use [MyCrypto](https://mycrypto.com/contracts/interact) to interact with the contracts. Contracts ABIs are stored in [build/contracts](build/contracts). The demos are hosted on Rinkeby - be sure to use the correct network in MyCrypto when you are trying to read from the pointsManager contract ;-)

Contract addresses:
* "0xdb3d883d2addbbcd9631548e9ee93d7bb8e1b77f",  // [Points manager](contracts/pointsManager.sol)
* "0x0928de0ad7ab871b7e1f390fd7d9eac26c37d752",  // [Ex1Contract](contracts/exercices/ex1.sol)
* "0x94165b15ab7df0618e58ea3bd872f7216e51cd06",  // [Ex2Contract](contracts/exercices/ex2.sol)
* "0x0e5b5bbb37f301ae54b66142d72c344843167b28",  // [Ex3Contract](contracts/exercices/ex3.sol)
* "0xc399ca4aa7e1d8c2b979ffaee610f9729b60889b",  // [Ex4Contract](contracts/exercices/ex4.sol)
* "0x14c8cad8ac280a332802080c423d5cd25fc6a8e1",  // [Ex5Contract](contracts/exercices/ex5.sol)
* "0x64400ba340c6f17219cbf5fc0f9d5920cf78fb7b",  // [Ex6Contract](contracts/exercices/ex6.sol)
* "0xe8d37087750f0880f8112647dbe3fa201cd649f7",  // [Ex7Contract](contracts/exercices/ex7.sol)
* "0x663995cad64413f19dbf9c2d6329d21e82bab551",  // [Ex8Contract](contracts/exercices/ex8.sol)
* "0x4e317932530c26fed7227b616afe37f47d02e721",  // [Ex9Contract](contracts/exercices/ex9.sol)
* "0x29777af07fad208b9dfa117eef117d79dba9219c",  // [Ex10Contract](contracts/exercices/ex10.sol)
* Undisclosed // [Ex11Contract](contracts/exercices/ex11.sol)

Next steps:
* Open exams to the general public

Organ addresses:
* "0x1ac09a756b3E33caec5d9a8D1Af64062847698A6",  // Students organ
* "0xbdB575cc6762080A4C262718Cf3645e9b5E7278B",  // Teachers organ
* "0xC6203fa33f0ED1Ba168f2d999ba6265BF6037F75",  // Exercices organ
