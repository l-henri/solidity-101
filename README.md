# solidity-101
A practice course on using Solidity Smart contracts.

This practice session has 11 exercices. The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students, credit points, and identify students using the [Kelsen](https://github.com/97network/Kelsen) framework.

Points are managed through the [pointManager](contracts/pointsManager.sol) contract. For the moment, only registered students can participate in the exercice. However, if you want to take a shot at the exercices, reach out to henri.lieutaud [at] ext.devinci.fr. The whole exam might be fully opened in the future.

You can use [MyCrypto](https://mycrypto.com/contracts/interact) to interact with the contracts. Contracts ABIs are stored in [build/contracts](build/contracts). The demos are hosted on Rinkeby - be sure to use the correct network in MyCrypto when you are trying to read from the pointsManager contract ;-)

Contract addresses:
* "0xdb3d883d2addbbcd9631548e9ee93d7bb8e1b77f",  // [Points manager](contracts/pointsManager.sol)
* "0xdf1cbc8f655c01cf95616188e03ad376c7e632c3",  // [Ex1Contract](contracts/exercices/ex1.sol)
* "0x6773ad900c18cf33fbd92bce0cf77b0c46da20b6",  // [Ex2Contract](contracts/exercices/ex2.sol)
* "0x78d97deb5235f317a1db2ee0488bdc21516c2dcd",  // [Ex3Contract](contracts/exercices/ex3.sol)
* "0x94126c9f3775fc88b947cb1026048165f1e7f769",  // [Ex4Contract](contracts/exercices/ex4.sol)
* "0x0d7387845d2dbff7dd2837a79ccf6f91793d65a1",  // [Ex5Contract](contracts/exercices/ex5.sol)
* "0x789dc197f408e67b6edbfaa05611f4a6c6f1d765",  // [Ex6Contract](contracts/exercices/ex6.sol)
* "0xc235d69d096534a9fa2c4e8088d2df6f7a0df8bb",  // [Ex7Contract](contracts/exercices/ex7.sol)
* "0xc0f15b7976cea7d3204bf23385ece62855833c8e",  // [Ex8Contract](contracts/exercices/ex8.sol)
* "0x7d51c588761445695f3bad8f784bfcf72123371e",  // [Ex9Contract](contracts/exercices/ex9.sol)
* "0x032d2cfb68e52956c18e2a6a67c09bb580b56eb7",  // [Ex10Contract](contracts/exercices/ex10.sol)
* Undisclosed // [Ex11Contract](contracts/exercices/ex11.sol)

Next steps:
* Open exams to the general public

Organ addresses:
* "0x1ac09a756b3E33caec5d9a8D1Af64062847698A6",  // Students organ
* "0xbdB575cc6762080A4C262718Cf3645e9b5E7278B",  // Teachers organ
* "0xC6203fa33f0ED1Ba168f2d999ba6265BF6037F75",  // Exercices organ
