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
        await remNorms(deployer, network, accounts);
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


async function remNorms(deployer, network, accounts) {
	// Adding norms
	console.log("Adding norms")

	await exercicesOrgan.addNorm(Ex7Contract.address, "Ex7", 0, 0, 0)
	await exercicesOrgan.addNorm(Ex10Contract.address, "Ex10", 0, 0, 0)
}






