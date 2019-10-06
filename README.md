# solidity-101
A practice course on using Solidity Smart contracts.

This practice session has 11 exercices. The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students, credit points, and identify students using the [Kelsen](https://github.com/97network/Kelsen) framework.

Points are managed through the [pointManager](contracts/pointsManager.sol) contract. For the moment, only registered students can participate in the exercice. However, if you want to take a shot at the exercices, reach out to henri.lieutaud [at] ext.devinci.fr. The whole exam might be fully opened in the future.

You can use [MyCrypto](https://mycrypto.com/contracts/interact) to interact with the contracts. Contracts ABIs are stored in [build/contracts](build/contracts). The demos are hosted on Rinkeby - be sure to use the correct network in MyCrypto when you are trying to read from the pointsManager contract ;-)

Contract addresses:
* "0xdb3d883d2addbbcd9631548e9ee93d7bb8e1b77f",  // [Points manager](contracts/pointsManager.sol)
* "0x14155A45e003BfD39577174274f9E71Eaff08B21",  // [Ex1Contract](contracts/exercices/ex1.sol)
* "0xD192C9824262CEe0d5Bc619fdeF8b0cfdce69472",  // [Ex2Contract](contracts/exercices/ex2.sol)
* "0xa66fde07BbfFC63Fe5f9535a74343A5764300976",  // [Ex3Contract](contracts/exercices/ex3.sol)
* "0x38Fce77e0fe496ea8e37c5109D5C07D7469cb73a",  // [Ex4Contract](contracts/exercices/ex4.sol)
* "0x9d4dBc35C10aba2DD00eC95389BA7c2919cf85f8",  // [Ex5Contract](contracts/exercices/ex5.sol)
* "0x1122682Aa2667f38cD49b2e7fe6219512B0dA2f4",  // [Ex6Contract](contracts/exercices/ex6.sol)
* "0x007Ad9cD1b7bCA8a13B174A082a3696Dd001917D",  // [Ex7Contract](contracts/exercices/ex7.sol)
* "0x625E831410f1bDFA513FE91bc2B33841f36Df69a",  // [Ex8Contract](contracts/exercices/ex8.sol)
* "0x21440258C6e12125E6AB7eD426aAF8ED3BC88732",  // [Ex9Contract](contracts/exercices/ex9.sol)
* "0xdA35106fbD0f6BbAe69524d556962a14C66E1aa5",  // [Ex10Contract](contracts/exercices/ex10.sol)
* "0x0F405422cD94F0f175B5EF9E716440dF0249A68e",  // [Ex11Contract](contracts/exercices/ex11.sol)
* Undisclosed // [Ex12Contract](contracts/exercices/ex12.sol)

Next steps:
* Open exams to the general public
* Grant point to students that help other students in ex5
* Correct bug in exercices 6, 7 and 10

Organ addresses:
* "0xdeb56d39c56879a03fb64f5b53a86f72b99ef8d4",  // Students organ
* "0x53bbf3A68bbd1e57c3eA8185e4e8C4895f9686a0",  // Teachers organ
* "0xf690815f0A9Da3E75A1f9F54318dC57b816bc612",  // Exercices organ
