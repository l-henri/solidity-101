var deployOrgan = artifacts.require("utils/Kelsen/deploy/deployOrgan")
var Organ = artifacts.require("utils/Kelsen/Organ")
var Migrations = artifacts.require("Migrations.sol");
var PointsManager = artifacts.require("pointsManager.sol");

var Ex1 = artifacts.require('exercices/ex1.sol')
var Ex2 = artifacts.require('exercices/ex2.sol')
var Ex3 = artifacts.require('exercices/ex3.sol')
var Ex4 = artifacts.require('exercices/ex4.sol')
var Ex5 = artifacts.require('exercices/ex5.sol')
var Ex6 = artifacts.require('exercices/ex6.sol')
var Ex7 = artifacts.require('exercices/ex7.sol')
var Ex8 = artifacts.require('exercices/ex8.sol')
var Ex9 = artifacts.require('exercices/ex9.sol')
var Ex10 = artifacts.require('exercices/ex10.sol')
var Ex11 = artifacts.require('exercices/ex11.sol')


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await organDeploy(deployer, network, accounts);
        await declareNewExercices(deployer, network, accounts);
        await addNewNorm(deployer, network, accounts);
        await setRandomValueStores(deployer, network, accounts);
        await deployRecap(deployer, network, accounts); 
        // await deployLibs(deployer, network, accounts);
        // await declareOrgans(deployer, network, accounts);
        // await declareProcedures(deployer, network, accounts);
        // await setOrganAdminsAndMasters(deployer, network, accounts);
        // await deployTokenAndInsurancePlan(deployer, network, accounts);
        // await setOrganNorms(deployer, network, accounts);
        // await cleanInstallation(deployer, network, accounts);
        // await installationRecap(deployer, network, accounts);
    });
};

async function organDeploy(deployer, network, accounts) {
	await deployer.deploy(Migrations);
	console.log("Deploying organs")
	studentsOrgan = Organ.at("0x208938037F710d0f9f6817a7C0411D3AF67288B2", {from: accounts[0]});
	teachersOrgan = Organ.at("0xDb0f9068547ecD6b71644Aa6e108E8361889b031", {from: accounts[0]});
	exercicesOrgan = Organ.at("0xC6203fa33f0ED1Ba168f2d999ba6265BF6037F75", {from: accounts[0]});
	pointsManagerContract = PointsManager.at("0xDb3D883D2aDDBBCd9631548E9Ee93d7bB8E1b77F");
}

async function declareNewExercices(deployer, network, accounts) {
	console.log("Deploying Points manager")
	console.log("Deploying Exercices")

	Ex6Contract = await Ex6.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex7Contract = await Ex7.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex10Contract = await Ex10.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
}

async function addNewNorm(deployer, network, accounts) {
	// Adding norms
	console.log("Adding norms")

	await exercicesOrgan.addNorm(Ex6Contract.address, "Ex6", 0, 0, 0)
	await exercicesOrgan.addNorm(Ex7Contract.address, "Ex7", 0, 0, 0)
	await exercicesOrgan.addNorm(Ex10Contract.address, "Ex10", 0, 0, 0)

}

async function setRandomValueStores(deployer, network, accounts) {
	console.log("Setting random value store")
	// await studentsOrgan.send(5000000000000000000, {from: accounts[0]});
	// Ex1Contract.newStudentInClass("0xeab83a73c1fd855beaf1d0b7a798e31526c291da", {from: accounts[0]});
	// test = await studentsOrgan.norms(await studentsOrgan.getAddressPositionInNorm('0xeab83a73c1fd855beaf1d0b7a798e31526c291da'))
	// console.log(test)
	randomValueStore1 = []
	randomValueStore2 = []
	randomValueStore3 = []
	for (i = 0; i < 20; i++)
		{
		randomValueStore1.push(Math.floor(Math.random()*10000))
		randomValueStore2.push(Math.floor(Math.random()*10000))
		randomValueStore3.push(Math.floor(Math.random()*10000))
		}
	await Ex6Contract.setRandomValueStore(randomValueStore1)
	await Ex7Contract.setRandomValueStore(randomValueStore2)
	await Ex10Contract.setRandomValueStore(randomValueStore3)
}

async function deployRecap(deployer, network, accounts) {
	console.log("Set up is finished and random value stores have been declared:")
	console.log(randomValueStore1)
	console.log(randomValueStore2)
	console.log(randomValueStore3)
	console.log("    \""+Ex6Contract.address+"\",  // (Ex6Contract)")
	console.log("    \""+Ex7Contract.address+"\",  // (Ex7Contract)")
	console.log("    \""+Ex10Contract.address+"\",  // (Ex10Contract)")
}




