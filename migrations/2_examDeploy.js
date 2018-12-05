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


console.log("0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD")
module.exports = function(deployer, network, accounts) {
	console.log("0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD")
  deployer.deploy(Migrations);

  	// Deploying organs
  	console.log("Deploying organs")


	const studentsOrgan = Organ.at("0x1ac09a756b3e33caec5d9a8d1af64062847698a6")
	const teachersOrgan = Organ.at("0xbdb575cc6762080a4c262718cf3645e9b5e7278b")
	const exercicesOrgan = Organ.at("0x158377d459a5c87eea86819384ef0f7a54d7b86b")

	
	
	

	// Deploying points manager
	console.log("Deploying points manager")
	deployer.deploy(PointsManager, studentsOrgan.address, teachersOrgan.address, exercicesOrgan.address).then(() => {
	const pointsManagerContract = PointsManager.at(PointsManager.address)

	//Creating exercices
	deployer.deploy(Ex1, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex1Contract = Ex1.at(Ex1.address)
	deployer.deploy(Ex2, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex2Contract = Ex2.at(Ex2.address)
	deployer.deploy(Ex3, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex3Contract = Ex3.at(Ex3.address)
	deployer.deploy(Ex4, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex4Contract = Ex4.at(Ex4.address)
	deployer.deploy(Ex5, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex5Contract = Ex5.at(Ex5.address)
	deployer.deploy(Ex6, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex6Contract = Ex6.at(Ex6.address)
	deployer.deploy(Ex7, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex7Contract = Ex7.at(Ex7.address)
	deployer.deploy(Ex8, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex8Contract = Ex8.at(Ex8.address)
	deployer.deploy(Ex9, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex9Contract = Ex9.at(Ex9.address)
	deployer.deploy(Ex10, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex10Contract = Ex10.at(Ex10.address)
	deployer.deploy(Ex11, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex11Contract = Ex11.at(Ex11.address)

	// Adding admins
	studentsOrgan.addAdmin("0x252536b7983e61e287d51459fef9ee034c82c7fb", true, true, true, true, "acc0").then(() => {
	studentsOrgan.addAdmin(Ex1Contract.address, true, true, true, true, "acc0").then(() => {
	teachersOrgan.addAdmin("0x252536b7983e61e287d51459fef9ee034c82c7fb", true, true, true, true, "acc0").then(() => {
	exercicesOrgan.addAdmin("0x252536b7983e61e287d51459fef9ee034c82c7fb", true, true, true, true, "acc0").then(() => {
		

	// Adding norms
	exercicesOrgan.addNorm(Ex1Contract.address, "Ex1", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex2Contract.address, "Ex2", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex3Contract.address, "Ex3", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex4Contract.address, "Ex4", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex5Contract.address, "Ex5", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex6Contract.address, "Ex6", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex7Contract.address, "Ex7", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex8Contract.address, "Ex8", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex9Contract.address, "Ex9", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex10Contract.address, "Ex10", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	exercicesOrgan.addNorm(Ex11Contract.address, "Ex11", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	teachersOrgan.addNorm("0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD", "acc0", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	teachersOrgan.addNorm("0x252536b7983e61e287d51459fef9ee034c82c7fb", "acc0", 0, 0, 0, {from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {

	Ex1Contract.newStudentInClass("0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD",{from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	randomValueStore1 = []
	randomValueStore2 = []
	randomValueStore3 = []
	for (i = 0; i < 20; i++)
		{
		randomValueStore1.push(Math.floor(Math.random()*10000))
		randomValueStore2.push(Math.floor(Math.random()*10000))
		randomValueStore3.push(Math.floor(Math.random()*10000))
		}
	
	Ex6Contract.setRandomValueStore(randomValueStore1,{from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	Ex7Contract.setRandomValueStore(randomValueStore2,{from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {
	Ex10Contract.setRandomValueStore(randomValueStore3,{from: "0x252536b7983e61e287d51459fef9ee034c82c7fb"}).then(() => {

	// Testing:
	//: Adding a student
	//Setting randomValueStore for ex6
	// Setting randomValueStore for ex7
	// Setting randomValueStore for ex10
	console.log("Set up is finished and random value stores have been declared:")
	console.log(randomValueStore1)
	console.log(randomValueStore2)
	console.log(randomValueStore3)

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

	
	})
	})
	})
	})
		})
		})
		})
		})
	})
		})
		})
		})
	})
		})
		})
		})
	})
		})
		})
		})

		})
		})
			})
		})
	})
		})
		})
		})
	})
		})
		})
		})

		})
	




};
