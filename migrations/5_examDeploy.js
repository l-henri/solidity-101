
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
	Ex5Contract = await Ex5.new(TDToken.address)
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

// truffle run verify ex01@0x6fA2b36f3751d245E8dEbe77304e46E5D9298660 --network goerli
// truffle run verify ex02@0xBeEd81F50c16F155825aeE26344b2D92e453Be42 --network goerli
// truffle run verify ex03@0x502DdDb2DFEc1732A51b657C1Dc3B98CA2630722 --network goerli
// truffle run verify ex04@0xE541Bc93a3064F71967075558e447c3C44AE9C9B --network goerli
// truffle run verify ex05@0x2188144ebBF299E30D623378E4AB8ba203fE4244 --network goerli
// truffle run verify ex06@0x39BAC501B2042dD3Ef0b30C5e342e4251488b131 --network goerli
// truffle run verify ex07@0xD1c4744992a03aEf15a395Cd0FD9Eed17f6200F2 --network goerli
// truffle run verify ex08@0x8734a14A33614Bc4A3Bd1327beEbf4559bdD1D85 --network goerli
// truffle run verify ex09@0x5b45c12627Dbc946eDfd4037ac10A37363Fb1E6E --network goerli
// truffle run verify ex10@0x4DE3bd213b88E02542EbEa053b5E158B1609655b --network goerli
// truffle run verify ex11@0xAF59931827E33e6AD912932f7750874B0fF63fe1 --network goerli
// truffle run verify ex11b@ --network goerli
// truffle run verify ex12@0xb082a7288b6582e2d9076cef511629dfbf18f61e --network goerli
// truffle run verify ex14@0x4B25880211b7bde9D212486feBc55236de86789F --network goerli
// truffle run verify ex15@0x38EB5DA6D2Ba7B2b86EF047fF11Bc2fB8558432F --network goerli
// truffle run verify ERC20TD@0xD1d29e244C91bA16CeACBa6C9735DE9b5e54DA57 --network goerli


