
var TDErc20 = artifacts.require("ERC20TD.sol");

var Ex1 = artifacts.require('exercices/ex01.sol')
var Ex2 = artifacts.require('exercices/ex02.sol')
var Ex3 = artifacts.require('exercices/ex03.sol')
var Ex4 = artifacts.require('exercices/ex04.sol')
var Ex5 = artifacts.require('exercices/ex05.sol')
var Ex6 = artifacts.require('exercices/ex06.sol')
var Ex7 = artifacts.require('exercices/ex07.sol')
var Ex8 = artifacts.require('exercices/ex08.sol')
var Ex9 = artifacts.require('exercices/ex09.sol')
var Ex10 = artifacts.require('exercices/ex10.sol')
var Ex11 = artifacts.require('exercices/ex11.sol')
var Ex11b = artifacts.require('exercices/ex11b.sol')
var Ex12 = artifacts.require('exercices/ex12.sol')

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployTDToken(deployer, network, accounts);
        await deployExercices(deployer, network, accounts);
        await setRandomValueStores(deployer, network, accounts);
        await setPermissions(deployer, network, accounts);
        await deployRecap(deployer, network, accounts); 
    });
};

async function deployTDToken(deployer, network, accounts) {
	TDToken = await TDErc20.new("TD-Solidity-101","TD-SOL-101",web3.utils.toBN("42069000000000000000000000000"))
}


async function deployExercices(deployer, network, accounts) {
	
	console.log("Deploying Exercices")
	Ex1Contract = await Ex1.new(TDToken.address) 
	Ex2Contract = await Ex2.new(TDToken.address)
	Ex3Contract = await Ex3.new(TDToken.address)
	Ex4Contract = await Ex4.new(TDToken.address)
	Ex5Contract = await Ex5.new(TDToken.address)
	Ex6Contract = await Ex6.new(TDToken.address)
	Ex7Contract = await Ex7.new(TDToken.address)
	Ex8Contract = await Ex8.new(TDToken.address)
	Ex9Contract = await Ex9.new(TDToken.address)
	Ex10Contract = await Ex10.new(TDToken.address)
	Ex11bContract = await Ex11b.new(TDToken.address)
	Ex11Contract = await Ex11.new(TDToken.address, Ex11bContract.address)
	Ex12Contract = await Ex12.new(TDToken.address)
}

async function setRandomValueStores(deployer, network, accounts) {
	console.log("Setting random value store")

	// var Ex6Contract = await Ex6.at('0xA9F5f2E49F93A6eD59a24Aa5FB81097E65e20D73')
	// var Ex7Contract = await Ex7.at('0x51330284182faEd4fBC8273711f7096fCcD60e5e')
	// var Ex10Contract = await Ex10.at('0x291dD0D61C9F876c5e5E81115f38967410c7f7CA')
	// var Ex11Contract = await Ex11.at('0xf1fC623176d712740c0038B59e054a9e9Fb286fA')
	// var Ex11bContract = await Ex11b.at('0xf1fc623176d712740c0038b59e054a9e9fb286fa')
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
	await Ex12Contract.askForPoints(0, Math.floor(Math.random()*10000))
}

async function setPermissions(deployer, network, accounts) {
	console.log("Setting permissions")

	await TDToken.setTeachers([Ex1Contract.address,
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
								Ex12Contract.address]);
}

async function deployRecap(deployer, network, accounts) {
	console.log("Set up is finished and random value stores have been declared:")
	console.log(randomValueStore1)
	console.log(randomValueStore2)
	console.log(randomValueStore3)
	console.log("    \""+TDToken.address+"\",  // (TDToken)")
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
	console.log("    \""+Ex11Contract.address+"\",  // (Ex10Contract)")
}




