# solidity-101
A practice course on using Solidity Smart contracts.

This practice session has 11 exercices. The instructions for each exercice are included in the contracts of each exercice, in [contracts/exercices](contracts/exercices). Each exercice contract inherits from the [exerciceTemplate](contracts/exerciceTemplate.sol), which holds common functions to validate students, credit points, and identify students using the [Kelsen](https://github.com/97network/Kelsen) framework.

Points are managed through the [pointManager](contracts/pointsManager.sol) contract. For the moment, only registered students can participate in the exercice. However, if you want to take a shot at the exercices, reach out to henri.lieutaud [at] ext.devinci.fr. The whole exam might be fully opened in the future.

You can use [MyCrypto](https://mycrypto.com/contracts/interact) to interact with the contracts. Contracts ABIs are stored in [build/contracts](build/contracts). The demos are hosted on Rinkeby - be sure to use the correct network in MyCrypto when you are trying to read from the pointsManager contract ;-)

Contract addresses:
* "0x173cfbcc3fdbfCCa2A90511FE7B9ca425564C983",  // [Points manager](contracts/pointsManager.sol)
* "0xbe7e5b95Bad8F304efbD9510EEe3382702AA411c",  // [Ex1Contract](contracts/exercices/ex1.sol)
* "0x78Cab5B8765c2E713e6364f0052b570fa01b2e7D",  // [Ex2Contract](contracts/exercices/ex2.sol)
* "0x2E6C56DF81F1192e8D69e3C38581A780C872583b",  // [Ex3Contract](contracts/exercices/ex3.sol)
* "0x55406074F608773847a68fF9AdAa8eF475708A99",  // [Ex4Contract](contracts/exercices/ex4.sol)
* "0x3C60C427C0696cFc83a6de4D3E41694650264046",  // [Ex5Contract](contracts/exercices/ex5.sol)
* "0xA9F5f2E49F93A6eD59a24Aa5FB81097E65e20D73",  // [Ex6Contract](contracts/exercices/ex6.sol)
* "0x51330284182faEd4fBC8273711f7096fCcD60e5e",  // [Ex7Contract](contracts/exercices/ex7.sol)
* "0xeda23675c8040dcFF4A33aA74701f1388deEcc8B",  // [Ex8Contract](contracts/exercices/ex8.sol)
* "0xEDC96502Db9594c0435eBa370f0A6F64Ae5581d5",  // [Ex9Contract](contracts/exercices/ex9.sol)
* "0x291dD0D61C9F876c5e5E81115f38967410c7f7CA",  // [Ex10Contract](contracts/exercices/ex10.sol)
* "0xf1fC623176d712740c0038B59e054a9e9Fb286fA",  // [Ex11Contract](contracts/exercices/ex11.sol)
* Undisclosed // [Ex12Contract](contracts/exercices/ex12.sol)

Next steps:
* Open exams to the general public
* Grant point to students that help other students in ex5
* Correct bug in exercices 6, 7 and 10

Organ addresses:
* "0x62B7E303098169CA2FE5bdDA2BAFcc42dDD58a70",  // Students organ
* "0xB34423173F36223C397ffAa5Bd13c2FaD5b5F82f",  // Teachers organ
* "0x036246770DDC3619a5477E826097B5BeFF8429A1",  // Exercices organ
