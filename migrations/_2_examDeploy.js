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


module.exports = function(deployer, network, accounts) {
  //deployer.deploy(Migrations);

  	// Deploying organs
  	console.log("Deploying organs")


  	deployer.deploy(deployOrgan, "studentsOrgan").then(() => {
  		//0x17f86f4023c340eddeb6982d404228ba4de3efa1
  		//0x6526c4c6f18e1176a12fefaf954bd150f28cecb0
  		//0x55c62fce2bf4ffd3edb5bf3870c29d6fbb0c7cc9
  		// const studentsOrgan = Organ.at("0x17f86f4023c340eddeb6982d404228ba4de3efa1");
 	deployer.deploy(deployOrgan, "teachersOrgan").then(() => {
  		// const teachersOrgan = Organ.at("0x6526c4c6f18e1176a12fefaf954bd150f28cecb0");
 	deployer.deploy(deployOrgan, "exercicesOrgan").then(() => {
		// const exercicesOrgan = Organ.at("0x55c62fce2bf4ffd3edb5bf3870c29d6fbb0c7cc9");
	
	

	// Deploying points manager
	console.log("Deploying points manager")
	//deployer.deploy(PointsManager, studentsOrgan.address, teachersOrgan.address, exercicesOrgan.address).then(() => {
	const pointsManagerContract = PointsManager.at("0x9a1de4175b404ec867cbc76869fdba113eda82ab")

	//Creating exercices
	//deployer.deploy(Ex1, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
		//0xd2d494d0d42087d5970fcdd564f71eb5d8aa9e94
	const Ex1Contract = Ex1.at("0xd2d494d0d42087d5970fcdd564f71eb5d8aa9e94")
	//deployer.deploy(Ex2, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex2Contract = Ex2.at("0x09b3ac0a526aa2b28ccd92dd086121e589bd557f")
	//deployer.deploy(Ex3, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex3Contract = Ex3.at("0xf96e5d26dddec7bfc13a4779505904c549cae1fd")
	//deployer.deploy(Ex4, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex4Contract = Ex4.at("0xfbffea69bd7ee92fc847d3a3a48d2d27f78e72b9")
	//deployer.deploy(Ex5, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex5Contract = Ex5.at("0x23f2bb2c037e024cd49638650e76fc9ff37b4f51")
	//deployer.deploy(Ex6, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex6Contract = Ex6.at("0xf37b6e8cad0dba924fce60f64d47ee521949b982")
	//deployer.deploy(Ex7, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex7Contract = Ex7.at("0x81f583ff6186dc0703c517d1ce54409944cb04bc")
	//deployer.deploy(Ex8, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex8Contract = Ex8.at("0xa1b995aee491e3cb72993e9cf5c76df662ad6821")
	//deployer.deploy(Ex9, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex9Contract = Ex9.at("0xbf2abe22af3e4182eed4ffd729d2a13fadddba16")
	//deployer.deploy(Ex10, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex10Contract = Ex10.at("0xa75c40aa31afe24e9648f6427eeea87de003c95f")
	//deployer.deploy(Ex11, studentsOrgan.address, teachersOrgan.address, pointsManagerContract.address).then(() => {
	const Ex11Contract = Ex11.at("0x668104224298ed101c69ca3d74154fe6beca0f19")

	// Adding admins
	studentsOrgan.addAdmin("0xa1c70389cb93a02d9a6609b4a9a1e80b85b61ffd", true, true, true, true, "acc0").then(() => {
	studentsOrgan.addAdmin(Ex1Contract.address, true, true, true, true, "acc0").then(() => {
	teachersOrgan.addAdmin("0xa1c70389cb93a02d9a6609b4a9a1e80b85b61ffd", true, true, true, true, "acc0").then(() => {
	teachersOrgan.addNorm("0xa1c70389cb93a02d9a6609b4a9a1e80b85b61ffd", "Henri", 0, 0, 0).then(() => {
	exercicesOrgan.addAdmin("0xa1c70389cb93a02d9a6609b4a9a1e80b85b61ffd", true, true, true, true, "acc0").then(() => {
		

	// Adding norms
	console.log("Adding norms")
	exercicesOrgan.addNorm(Ex1Contract.address, "Ex1", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex2Contract.address, "Ex2", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex3Contract.address, "Ex3", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex4Contract.address, "Ex4", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex5Contract.address, "Ex5", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex6Contract.address, "Ex6", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex7Contract.address, "Ex7", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex8Contract.address, "Ex8", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	exercicesOrgan.addNorm(Ex9Contract.address, "Ex9", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {

	exercicesOrgan.addNorm(Ex10Contract.address, "Ex10", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {

	exercicesOrgan.addNorm(Ex11Contract.address, "Ex11", 0, 0, 0, {from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {

	// Adding new studant
	console.log('Ici	')
	Ex1Contract.newStudentInClass("0xa1c70389cb93a02d9a6609b4a9a1e80b85b61ffd",{from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	randomValueStore1 = []
	randomValueStore2 = []
	randomValueStore3 = []
	for (i = 0; i < 20; i++)
		{
		randomValueStore1.push(Math.floor(Math.random()*10000))
		randomValueStore2.push(Math.floor(Math.random()*10000))
		randomValueStore3.push(Math.floor(Math.random()*10000))
		}
	console.log('Ici	')
	Ex6Contract.setRandomValueStore(randomValueStore1,{from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	Ex7Contract.setRandomValueStore(randomValueStore2,{from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {
	Ex10Contract.setRandomValueStore(randomValueStore3,{from: "0xa1C70389cB93a02d9A6609b4a9A1e80b85B61fFD"}).then(() => {

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

		//})
		//})
		//	})
		//})
	//})
		//})
	//	})
	//	})
	//})
		//})
		//})
//		})

		

		





};
