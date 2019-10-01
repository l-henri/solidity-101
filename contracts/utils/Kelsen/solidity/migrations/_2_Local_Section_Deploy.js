// Organs
var deployOrgan = artifacts.require("deployOrgan")
var Organ = artifacts.require("Organ")
// Presidential election
var deployCyclicalManyToOneElectionProcedure = artifacts.require("deploy/deployCyclicalManyToOneElectionProcedure")
var cyclicalManyToOneElectionProcedure = artifacts.require("procedures/cyclicalManyToOneElectionProcedure")
// Moderators election
var deployCyclicalManyToManyElectionProcedure = artifacts.require("deploy/deployCyclicalManyToManyElectionProcedure")
var cyclicalManyToManyElectionProcedure = artifacts.require("procedures/cyclicalManyToManyElectionProcedure")
// Contract Promulgation
var deployVoteOnNormsProcedure = artifacts.require("deploy/deployVoteOnNormsProcedure")
var voteOnNormsProcedure = artifacts.require("procedures/voteOnNormsProcedure")
// Simple Nomination
var deploySimpleNormNominationProcedure = artifacts.require("deploy/deploySimpleNormNominationProcedure")
var simpleNormNominationProcedure = artifacts.require("procedures/simpleNormNominationProcedure")
// Constitutionnal reform
var deploySimpleAdminsAndMasterNominationProcedure = artifacts.require("deploy/deploySimpleAdminsAndMasterNominationProcedure")
var simpleAdminsAndMasterNominationProcedure = artifacts.require("procedures/simpleAdminsAndMasterNominationProcedure")


module.exports = function(deployer, network, accounts) {

  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("Deploying a local section with full admin control")
  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("-------------------------------------")
  console.log("Available accounts : ")
  accounts.forEach((account, i) => console.log("-", account))
  console.log("-------------------------------------")
  console.log("Initial balance:")
  console.log(web3.eth.getBalance(accounts[0]).toString(10))
  console.log("-------------------------------------")
  console.log("Deploying Organs")

  // 6 organs to deploy: Admins, Members, President, Moderators, Secretary, Active contracts
  // Deploy First organ (admins)
  deployer.deploy(deployOrgan, "Admins Organ", {from: accounts[0]}).then(() => {
  const adminOrgan = Organ.at(deployOrgan.address)
  // Deploy Second organ (member registry)
  deployer.deploy(deployOrgan, "Member Organ", {from: accounts[0]}).then(() => {
  const memberRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy Third organ (president registry)
  deployer.deploy(deployOrgan, "Presidential Organ", {from: accounts[0]}).then(() => {
  const presidentRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy third organ (admins)
  deployer.deploy(deployOrgan, "Moderators Organ", {from: accounts[0]}).then(() => {
  const moderatorsOrgan = Organ.at(deployOrgan.address)
  // Deploy third organ (admins)
  deployer.deploy(deployOrgan, "Secretary Organ", {from: accounts[0]}).then(() => {
  const secretaryOrgan = Organ.at(deployOrgan.address)
  // Deploy third organ (admins)
  deployer.deploy(deployOrgan, "Active contracts Organ", {from: accounts[0]}).then(() => {
    const activeContractsOrgan = Organ.at(deployOrgan.address)
    console.log("-------------------------------------")
    console.log("Deploying Procedures")
    // Deploying 5 procedures: Presidential election, moderators election, contract promulgation, simple nomination, constitutionnal reform
    // Deploy presidential election procedure
    // voteVariablesVector = [40, 3*60, 3*60, 9*60,2,2]
    // voteVariablesVector = [web3.toBigNumber(40).valueOf(), web3.toBigNumber(3*60).valueOf(), web3.toBigNumber(3*60).valueOf(), web3.toBigNumber(9*60).valueOf(),web3.toBigNumber(2).valueOf(),web3.toBigNumber(2).valueOf()]
    deployer.deploy(deployCyclicalManyToOneElectionProcedure, memberRegistryOrgan.address, presidentRegistryOrgan.address , "Presidential election", {from: accounts[0]}).then(() => {
    const presidentialElection = cyclicalManyToOneElectionProcedure.at(deployCyclicalManyToOneElectionProcedure.address)
    // Deploy Moderators election procedure
    deployer.deploy(deployCyclicalManyToManyElectionProcedure, memberRegistryOrgan.address, moderatorsOrgan.address,  "Moderators election", {from: accounts[0]}).then(() => {
    const moderatorsElection = cyclicalManyToManyElectionProcedure.at(deployCyclicalManyToManyElectionProcedure.address)
    // Deploy contract promulgation procedure
    voteDurationInSeconds = 60*3
    deployer.deploy(deployVoteOnNormsProcedure, activeContractsOrgan.address, moderatorsOrgan.address, secretaryOrgan.address, presidentRegistryOrgan.address, 40, voteDurationInSeconds, voteDurationInSeconds, 50, "Contract Promulgation", {from: accounts[0]}).then(() => {
    const promulgationProcess = voteOnNormsProcedure.at(deployVoteOnNormsProcedure.address)
    
    // Deploy simple nomination procedure
    deployer.deploy(deploySimpleNormNominationProcedure, adminOrgan.address, "Simple Nomination", {from: accounts[0]}).then(() => {
    const simpleNomination = simpleNormNominationProcedure.at(deploySimpleNormNominationProcedure.address)
    // Deploy constitutionnal reform procedure
    deployer.deploy(deploySimpleAdminsAndMasterNominationProcedure, adminOrgan.address, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      const constitutionnalReform = simpleAdminsAndMasterNominationProcedure.at(deploySimpleAdminsAndMasterNominationProcedure.address)
      console.log("-------------------------------------")
      console.log("Crediting masters")
      adminOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      memberRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      presidentRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      moderatorsOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      secretaryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      activeContractsOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
        console.log("-------------------------------------")
        console.log("Crediting admins")
        adminOrgan.addAdmin(simpleNomination.address, true, true, false, false, "Simple Nomination", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(simpleNomination.address, true, true, false, false, "Simple Nomination", {from: accounts[0]}).then(() => {
        presidentRegistryOrgan.addAdmin(presidentialElection.address, true, true, false, false, "Presidential election", {from: accounts[0]}).then(() => {
        moderatorsOrgan.addAdmin(moderatorsElection.address, true, true, false, false, "Moderators election", {from: accounts[0]}).then(() => {
        secretaryOrgan.addAdmin(simpleNomination.address, true, true, false, false, "Simple Nomination", {from: accounts[0]}).then(() => {
        activeContractsOrgan.addAdmin(promulgationProcess.address, true, true, false, false, "Promulgation", {from: accounts[0]}).then(() => {
        adminOrgan.addAdmin(accounts[0], true, true, false, false, "Temp admin", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(accounts[0], true, true, false, false, "Temp admin", {from: accounts[0]}).then(() => {
          console.log("-------------------------------------")
          console.log("Crediting norms")
          memberRegistryOrgan.addNorm(accounts[0], "Member 0", 1, 1, 1, {from: accounts[0]}).then(() => {
          memberRegistryOrgan.addNorm(accounts[1], "Member 1", 1, 1, 1, {from: accounts[0]}).then(() => {
          memberRegistryOrgan.addNorm(accounts[2], "Member 2", 1, 1, 1, {from: accounts[0]}).then(() => {
          memberRegistryOrgan.addNorm(accounts[3], "Member 3", 1, 1, 1, {from: accounts[0]}).then(() => {
          memberRegistryOrgan.addNorm(accounts[4], "Member 4", 1, 1, 1, {from: accounts[0]}).then(() => {
          adminOrgan.addNorm(accounts[0], "Member 0", 1, 1, 1, {from: accounts[0]}).then(() => {
            console.log("-------------------------------------")
            console.log("Removing temp admins")
            memberRegistryOrgan.remAdmin(accounts[0], {from: accounts[0]}).then(() => {
            adminOrgan.remAdmin(accounts[0], {from: accounts[0]}).then(() => {
              console.log("-------------------------------------")
              console.log("Removing temp masters")
              adminOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              memberRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              presidentRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              moderatorsOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              secretaryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              activeContractsOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
                console.log("Test name display")
                presidentialElection.getProcedureName().then(myInfos1 => {
                moderatorsElection.getProcedureName().then(myInfos2 => {
                promulgationProcess.getProcedureName().then(myInfos3 => {
                simpleNomination.getProcedureName().then(myInfos4 => {
                constitutionnalReform.getProcedureName().then(myInfos5 => {
                 // console.log("Test getLinkedOrgans display")
                //  presidentialElection.getLinkedOrgans().then(myInfos1 => {
                  //moderatorsElection.getLinkedOrgans().then(myInfos2 => {
                 // promulgationProcess.getLinkedOrgans().then(myInfos3 => {
                  //simpleNomination.getLinkedOrgans().then(myInfos4 => {
                  //constitutionnalReform.getLinkedOrgans().then(myInfos5 => {
                    console.log(myInfos1)
                    console.log(myInfos2)
                    console.log(myInfos3)
                    console.log(myInfos4)
                    console.log(myInfos5)


                      // Set up is ready

                      console.log("-------------------------------------")
                      console.log("Put these new addresses in settings :")
                      console.log("  \"organs_addresses\": [")
                      console.log("    \""+adminOrgan.address+"\",  // (Admins)")
                      console.log("    \""+memberRegistryOrgan.address+"\",  // (Members)")
                      console.log("    \""+presidentRegistryOrgan.address+"\",  // (Presidents)")
                      console.log("    \""+moderatorsOrgan.address+"\",  // (Moderators)")
                      console.log("    \""+secretaryOrgan.address+"\",  // (Secretary)")
                      console.log("    \""+activeContractsOrgan.address+"\",  // (Active contracts)")
                      console.log("  ],")
                      console.log("  \"procedures_addresses\": [")
                      console.log("    \""+presidentialElection.address+"\",  // (Presidential election)")
                      console.log("    \""+moderatorsElection.address+"\",  // (Moderators election)")
                      console.log("    \""+promulgationProcess.address+"\",  // (Promulgation)")
                      console.log("    \""+simpleNomination.address+"\",  // (Simple Nomination)")
                      console.log("    \""+constitutionnalReform.address+"\",  // (Constitutionnal reform)")
                      console.log("  ]")
                      console.log("Accounts 0 to 4 have been added as members")
                      console.log("Accounts 0 is an admin")
                      console.log("-------------------------------------")
                      console.log("Final balance:")
                      console.log(web3.eth.getBalance(accounts[0]).toString(10))

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
                  })
                })
              })
            })
          })
        })
})})})})})
  // Use deployer to state migration tasks.
};
