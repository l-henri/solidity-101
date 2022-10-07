
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
var Ex14 = artifacts.require('exercices/ex14.sol')
var Ex15 = artifacts.require('exercices/ex15.sol')

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
	Ex5Contract = await Ex5.new("0x61eCfB24Ce76B0B61D900E85719334902B95737D")
	Ex6Contract = await Ex6.new(TDToken.address)
	Ex7Contract = await Ex7.new(TDToken.address)
	Ex8Contract = await Ex8.new(TDToken.address)
	Ex9Contract = await Ex9.new(TDToken.address)
	Ex10Contract = await Ex10.new(TDToken.address)
	Ex11bContract = await Ex11b.new(TDToken.address)
	Ex11Contract = await Ex11.new(TDToken.address, Ex11bContract.address)
	Ex12Contract = await Ex12.new(TDToken.address)
	Ex14Contract = await Ex14.new(TDToken.address)
	Ex15Contract = await Ex15.new(TDToken.address)
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
								Ex12Contract.address,
								Ex14Contract.address,
								Ex15Contract.address]);
	await Ex12Contract.askForPoints(0, Math.floor(Math.random()*10000))
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
	console.log("    \""+Ex11Contract.address+"\",  // (Ex11Contract)")
	console.log("    \""+Ex14Contract.address+"\",  // (Ex14Contract)")
	console.log("    \""+Ex15Contract.address+"\",  // (Ex15Contract)")
}

// truffle run verify ex02@0x6dDdd446701759fa8BA3597bE9A9E01FF5691b8b --network goerli
// truffle run verify ex03@0xDD99B361ff42adffA8399CCf9EbCa6b03EF374A1 --network goerli
// truffle run verify ex04@0xB70B0add66f7D889E8d2235FFba3934039A4A4b6 --network goerli
// truffle run verify ex05@0x1c0989ba7ce3bcf39f8987b3dabc8ba03545bb57 --network goerli
// truffle run verify ex06@0xB4e89746B7Ba2A781b7160f435D361140c230185 --network goerli
// truffle run verify ex07@0x37531680e552ba80604750C2A0cCe7C57f94C6f2 --network goerli
// truffle run verify ex08@0xeD89a2F4771E3A9d6D0C49A9Eb595e4a9A169D40 --network goerli
// truffle run verify ex10@0x1499C24FbfB3BE0f8f84E1FAa0539849362cB2bF --network goerli
// truffle run verify ex11@0xB34423173F36223C397ffAa5Bd13c2FaD5b5F82f --network goerli
// truffle run verify ex11b@ --network goerli
// truffle run verify ex12@ --network goerli
// truffle run verify ex14@0xeda23675c8040dcff4a33aa74701f1388deecc8b --network goerli
// truffle run verify ex15@0x51330284182faed4fbc8273711f7096fccd60e5e --network goerli
// truffle run verify ERC20TD@0x61eCfB24Ce76B0B61D900E85719334902B95737D --network goerli


