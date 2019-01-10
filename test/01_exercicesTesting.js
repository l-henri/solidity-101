const StandardOrganDeploy = artifacts.require('./utils/Kelsen/deploy/deployOrgan.sol')
const PointsManager = artifacts.require('./pointsManager.sol')
const Ex1 = artifacts.require('./exercices/ex1.sol')
const Ex2 = artifacts.require('./exercices/ex2.sol')
const Ex3 = artifacts.require('./exercices/ex3.sol')
const Ex4 = artifacts.require('./exercices/ex4.sol')
const Ex5 = artifacts.require('./exercices/ex5.sol')
const Ex6 = artifacts.require('./exercices/ex6.sol')
const Ex7 = artifacts.require('./exercices/ex7.sol')
const Ex8 = artifacts.require('./exercices/ex8.sol')
const Ex9 = artifacts.require('./exercices/ex9.sol')
const Ex10 = artifacts.require('./exercices/ex10.sol')

let tryCatch = require("./exceptions.js").tryCatch;
let errTypes = require("./exceptions.js").errTypes;

contract('Exercices tests', function (accounts) {
	let ex1Contract
	let ex2Contract
	let ex3Contract
	let ex4Contract
	let ex5Contract
	let ex6Contract
	let ex7Contract
	let ex8Contract
	let ex9Contract
	let ex10Contract

	// Setup
    beforeEach('setup contract for each test', async function () {
    	// Defining organs
    	studentsOrgan = await StandardOrganDeploy.new("studentsOrgan", {from: accounts[0]})
    	teachersOrgan = await StandardOrganDeploy.new("teachersOrgan", {from: accounts[0]})
    	exercicesOrgan = await StandardOrganDeploy.new("exercicesOrgan", {from: accounts[0]})

    	// Creating point manager
    	pointsManager = await PointsManager.new(studentsOrgan.address, teachersOrgan.address, exercicesOrgan.address, {from: accounts[0]})
    	// Creating exercices
    	ex1Contract = await Ex1.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex2Contract = await Ex2.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex3Contract = await Ex3.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex4Contract = await Ex4.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex5Contract = await Ex5.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex6Contract = await Ex6.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex7Contract = await Ex7.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex8Contract = await Ex8.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex9Contract = await Ex9.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})
    	ex10Contract = await Ex10.new(studentsOrgan.address, teachersOrgan.address, pointsManager.address, {from: accounts[0]})

    	// Defining admins
    	await studentsOrgan.addAdmin(accounts[0], true, true, true, true, "acc0", {from: accounts[0]})
    	await studentsOrgan.addAdmin(ex1Contract.address, true, true, true, true, "Ex1", {from: accounts[0]})
    	await teachersOrgan.addAdmin(accounts[0], true, true, true, true, "acc0", {from: accounts[0]})
    	await exercicesOrgan.addAdmin(accounts[0], true, true, true, true, "acc0", {from: accounts[0]})

    	// Defining norms
    	await exercicesOrgan.addNorm(ex1Contract.address, "Ex1", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex2Contract.address, "Ex2", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex3Contract.address, "Ex3", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex4Contract.address, "Ex4", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex5Contract.address, "Ex5", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex6Contract.address, "Ex6", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex7Contract.address, "Ex7", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex8Contract.address, "Ex8", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex9Contract.address, "Ex9", 0, 0, 0, {from: accounts[0]})
    	await exercicesOrgan.addNorm(ex10Contract.address, "Ex10", 0, 0, 0, {from: accounts[0]})
    	await teachersOrgan.addNorm(accounts[0], "acc0", 0, 0, 0, {from: accounts[0]})

    	// Adding two student
    	await ex1Contract.newStudentInClass(accounts[1],{from: accounts[0]}); 
    	await ex1Contract.newStudentInClass(accounts[2],{from: accounts[0]}); 
        
       
    })

    // New subscriptions
    it('Ex1 new student can subscribe', async function (){

	await ex1Contract.newStudentInClass(accounts[3],{from: accounts[0]}); 
	studentGrade = await pointsManager.grades(accounts[3])
    assert.equal(studentGrade, 200)

    })
    it('Ex2 works as designed', async function (){
    await web3.eth.sendTransaction({to: ex2Contract.address,value:1000,from: accounts[1]})

	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })

    it('Ex3 works as designed', async function (){
    await ex3Contract.claimPoints(180618,{from: accounts[1]});
    await tryCatch(ex3Contract.claimPoints(180618,{from: accounts[1]}), errTypes.revert);

	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })
    it('Ex4 works as designed', async function (){
    await ex4Contract.initCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.initCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.incrementCounter({from: accounts[1]});
    await ex4Contract.decrementCounter({from: accounts[1]});
    await ex4Contract.validateCounter({from: accounts[1]});

	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })
    it('Ex5 works as designed', async function (){
    await ex5Contract.declareHelper(accounts[2],{from: accounts[1]});
    await ex5Contract.helpColleague(accounts[1],{from: accounts[2]});


	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })
    it('Ex6 works as designed', async function (){
    randomValueStore = [58,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    await ex6Contract.setRandomValueStore(randomValueStore,{from: accounts[0]});
    await ex6Contract.startExercice({from: accounts[1]});
    publicValue = await ex6Contract.publicValues(accounts[1],{from: accounts[1]});
    await tryCatch(ex6Contract.showYouKnowPrivateValue(publicValue,{from: accounts[1]}), errTypes.revert);
    await ex6Contract.duplicatePrivateValueInPublic({from: accounts[1]});
    publicValue = await ex6Contract.publicValues(accounts[1],{from: accounts[1]});
    await ex6Contract.showYouKnowPrivateValue(publicValue-85,{from: accounts[1]});


	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })
    it('Ex8 works as designed', async function (){
    await ex8Contract.createObject("Robert",{from: accounts[1]});
    await tryCatch(ex8Contract.claimPoints(0,{from: accounts[1]}), errTypes.revert);
    await ex8Contract.transfer(0, accounts[0],{from: accounts[1]});
    await tryCatch(ex8Contract.claimPoints(0,{from: accounts[1]}), errTypes.revert);
    await ex8Contract.transfer(0, accounts[1],{from: accounts[0]});
    await ex8Contract.changeObjectName(0, "Roberta",{from: accounts[1]});
    await ex8Contract.transfer(0, accounts[0],{from: accounts[1]});
    await ex8Contract.claimPoints(0,{from: accounts[1]})

	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })

    it('Ex9 works as designed', async function (){
    await tryCatch(ex9Contract.collectYourPoints(9838,{from: accounts[1]}), errTypes.revert);
    await ex9Contract.collectYourPoints(982738,{from: accounts[1]});


	studentGrade = await pointsManager.grades(accounts[1])
    assert.equal(studentGrade, 400)
    })



})