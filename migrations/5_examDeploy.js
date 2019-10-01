var organLibrary = artifacts.require("utils/Kelsen/solidity/contracts/libraries/organLibrary")
var Organ = artifacts.require("utils/Kelsen/solidity/contracts/Organ")
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
var Ex11b = artifacts.require('exercices/ex11b.sol')
var Ex12 = artifacts.require('exercices/ex12.sol')

module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await organDeploy(deployer, network, accounts);
        await pointsManagerAndExercices(deployer, network, accounts);
        await addingAdminsAndNorms(deployer, network, accounts);
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
	    console.log("Deploying libraries")
    await deployer.deploy(organLibrary);
    await deployer.link(organLibrary, [Organ]);
	await deployer.deploy(Migrations);
	console.log("Deploying organs")

	studentsOrgan = await Organ.new(web3.utils.fromAscii("studentsOrgan"), {from: accounts[0]});
	teachersOrgan = await Organ.new(web3.utils.fromAscii("teachersOrgan"), {from: accounts[0]});
	exercicesOrgan = await Organ.new(web3.utils.fromAscii("exercicesOrgan"), {from: accounts[0]});

}

async function pointsManagerAndExercices(deployer, network, accounts) {
	console.log("Deploying Points manager")
	pointsManagerContract = await PointsManager.new(studentsOrgan.address, teachersOrgan.address, exercicesOrgan.address, {from: accounts[0]});
	console.log("Deploying Exercices")
	Ex1Contract = await Ex1.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address, {from: accounts[0]});
	Ex2Contract = await Ex2.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex3Contract = await Ex3.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex4Contract = await Ex4.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex5Contract = await Ex5.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex6Contract = await Ex6.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex7Contract = await Ex7.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex8Contract = await Ex8.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex9Contract = await Ex9.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex10Contract = await Ex10.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex11Contract = await Ex11.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex11bContract = await Ex11b.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
	Ex12Contract = await Ex12.new(studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address)
}

async function addingAdminsAndNorms(deployer, network, accounts) {
	console.log("Adding admins and norms")	
	await studentsOrgan.addAdmin(Ex1Contract.address, true, true, true, true);	
	await studentsOrgan.addAdmin(accounts[0], true, true, true, true, {from: accounts[0]});
	await teachersOrgan.addAdmin(accounts[0], true, true, true, true);
	await teachersOrgan.addNorm(accounts[0], web3.utils.fromAscii('0'), 0, 0);
	await exercicesOrgan.addAdmin(accounts[0], true, true, true, true);
		
	// Adding norms
	console.log("Adding norms")
	await exercicesOrgan.addNorm(Ex1Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex2Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex3Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex4Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex5Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex6Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex7Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex8Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex9Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex10Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex11Contract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex11bContract.address, web3.utils.fromAscii('0'), 0, 0)
	await exercicesOrgan.addNorm(Ex12Contract.address, web3.utils.fromAscii('0'), 0, 0)


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
	await Ex11Contract.setex11bAddress(Ex11bContract.address)
	randomSecretEx11 = Math.floor(Math.random()*10000)
	await Ex11bContract.setSecretValue(randomSecretEx11)
}

async function deployRecap(deployer, network, accounts) {
	console.log("Set up is finished and random value stores have been declared:")
	console.log(randomValueStore1)
	console.log(randomValueStore2)
	console.log(randomValueStore3)
	console.log(randomSecretEx11)

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




