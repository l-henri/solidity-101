// Deploying the TD somewhere
// To verify it on Etherscan:
// npx hardhat verify --network sepolia <address> <constructor arg 1> <constructor arg 2>

const hre = require("hardhat");
const Str = require('@supercharge/strings')

async function main() {

  	// Deploying contracts
    console.log("Deploying ERC20")
    const ERC20TD = await hre.ethers.getContractFactory("ERC20TD");
    const erc20 = await ERC20TD.deploy("TD-Solidity-101","TD-SOL-101",0);
    
    await erc20.deployed();
    console.log("Deploying Exercices")
    const Ex1 = await hre.ethers.getContractFactory("ex01");
    const Ex2 = await hre.ethers.getContractFactory("ex02");
    const Ex3 = await hre.ethers.getContractFactory("ex03");
    const Ex4 = await hre.ethers.getContractFactory("ex04");
    const Ex5 = await hre.ethers.getContractFactory("ex05");
    const Ex6 = await hre.ethers.getContractFactory("ex06");
    const Ex7 = await hre.ethers.getContractFactory("ex07");
    const Ex8 = await hre.ethers.getContractFactory("ex08");
    const Ex9 = await hre.ethers.getContractFactory("ex09");
    const Ex10 = await hre.ethers.getContractFactory("ex10");
    const Ex11 = await hre.ethers.getContractFactory("ex11");
    const Ex11b = await hre.ethers.getContractFactory("ex11b");
    const Ex12 = await hre.ethers.getContractFactory("ex12");
    const Ex14 = await hre.ethers.getContractFactory("ex14");
    const Ex15 = await hre.ethers.getContractFactory("ex15");
  
    const Ex1Contract = await Ex1.deploy(erc20.address);
    const Ex2Contract = await Ex2.deploy(erc20.address);
    const Ex3Contract = await Ex3.deploy(erc20.address);
    const Ex4Contract = await Ex4.deploy(erc20.address);
    const Ex5Contract = await Ex5.deploy(erc20.address);
    const Ex6Contract = await Ex6.deploy(erc20.address);
    const Ex7Contract = await Ex7.deploy(erc20.address);
    const Ex8Contract = await Ex8.deploy(erc20.address);
    const Ex9Contract = await Ex9.deploy(erc20.address);
    const Ex10Contract = await Ex10.deploy(erc20.address);
    const Ex11bContract = await Ex11b.deploy(erc20.address);
    const Ex11Contract = await Ex11.deploy(erc20.address, Ex11bContract.address);
    const Ex12Contract = await Ex12.deploy(erc20.address);
    const Ex14Contract = await Ex14.deploy(erc20.address);
    const Ex15Contract = await Ex15.deploy(erc20.address);
    console.log("    \""+erc20.address+"\",  // (erc20)")
    console.log("    \""+Ex1Contract.address+"\",  // (Ex1Contract)")
    console.log("    \""+Ex2Contract.address+"\",  // (Ex2Contract)")
    console.log("    \""+Ex3Contract.address+"\",  // (Ex3Contract)")
    console.log("    \""+Ex4Contract.address+"\",  // (Ex4Contract)")
    console.log("    \""+Ex5Contract.address+"\",  // (Ex5Contract)")
    console.log("    \""+Ex6Contract.address+"\",  // (Ex6Contract)")
    console.log("    \""+Ex7Contract.address+"\",  // (Ex7Contract)")
    console.log("    \""+Ex8Contract.address+"\",  // (Ex8Contract)")
    console.log("    \""+Ex9Contract.address+"\",  // (Ex9Contract)")
    console.log("    \""+Ex10Contract.address+"\",  // (Ex10Contract)")
    console.log("    \""+Ex11Contract.address+"\",  // (Ex11Contract)")
    console.log("    \""+Ex11bContract.address+"\",  // (Ex11bContract)")
    console.log("    \""+Ex12Contract.address+"\",  // (Ex12Contract)")
    console.log("    \""+Ex14Contract.address+"\",  // (Ex14Contract)")
    console.log("    \""+Ex15Contract.address+"\",  // (Ex15Contract)")
  
    console.log("Setting random value store")
  
    randomValueStore1 = []
    randomValueStore2 = []
    randomValueStore3 = []
    for (i = 0; i < 20; i++)
      {
      randomValueStore1.push(Math.floor(Math.random()*10000))
      randomValueStore2.push(Math.floor(Math.random()*10000))
      randomValueStore3.push(Math.floor(Math.random()*10000))
      }
    await Ex6Contract.setRandomValueStore(randomValueStore1);
    await Ex7Contract.setRandomValueStore(randomValueStore2);
    await Ex10Contract.setRandomValueStore(randomValueStore3);
    console.log("Setting permissions")
  
    await erc20.setTeachers([Ex1Contract.address,
                  Ex2Contract.address,
                  Ex3Contract.address,
                  Ex4Contract.address,
                  Ex5Contract.address,
                  Ex6Contract.address,
                  Ex7Contract.address,
                  Ex8Contract.address,
                  Ex9Contract.address,
                  Ex10Contract.address,
                  Ex11Contract.address,
                  Ex12Contract.address,
                  Ex14Contract.address,
                  Ex15Contract.address]);
    await Ex12Contract.askForPoints(0, Math.floor(Math.random()*10000))
  
    console.log("Set up is finished and random value stores have been declared:")
    console.log(randomValueStore1)
    console.log(randomValueStore2)
    console.log(randomValueStore3)
    console.log("    \""+erc20.address+"\",  // (erc20)")
    console.log("    \""+Ex1Contract.address+"\",  // (Ex1Contract)")
    console.log("    \""+Ex2Contract.address+"\",  // (Ex2Contract)")
    console.log("    \""+Ex3Contract.address+"\",  // (Ex3Contract)")
    console.log("    \""+Ex4Contract.address+"\",  // (Ex4Contract)")
    console.log("    \""+Ex5Contract.address+"\",  // (Ex5Contract)")
    console.log("    \""+Ex6Contract.address+"\",  // (Ex6Contract)")
    console.log("    \""+Ex7Contract.address+"\",  // (Ex7Contract)")
    console.log("    \""+Ex8Contract.address+"\",  // (Ex8Contract)")
    console.log("    \""+Ex9Contract.address+"\",  // (Ex9Contract)")
    console.log("    \""+Ex10Contract.address+"\",  // (Ex10Contract)")
    console.log("    \""+Ex11Contract.address+"\",  // (Ex11Contract)")
    console.log("    \""+Ex14Contract.address+"\",  // (Ex14Contract)")
    console.log("    \""+Ex15Contract.address+"\",  // (Ex15Contract)")
  

  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


