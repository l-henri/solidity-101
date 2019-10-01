

/// Importing required contracts
// Organs
var deployOrgan = artifacts.require("deployOrgan")
var Organ = artifacts.require("Organ")

// Cyclical ManyToOne
var deployCyclicalManyToOneElectionProcedure = artifacts.require("deploy/deployCyclicalManyToOneElectionProcedure")
var cyclicalManyToOneElectionProcedure = artifacts.require("procedures/cyclicalManyToOneElectionProcedure")

// Cyclical ManyToMany
var deployCyclicalManyToManyElectionProcedure = artifacts.require("deploy/deployCyclicalManyToManyElectionProcedure")
var cyclicalManyToManyElectionProcedure = artifacts.require("procedures/cyclicalManyToManyElectionProcedure")

// Deposit Funds procedure
var deployDepositFundsProcedure = artifacts.require("deploy/deployDepositWithdrawFundsProcedure")
var depositFundsProcedure = artifacts.require("procedures/depositWithdrawFundsProcedure")

// Cooptation
var deployNormsCooptationProcedure = artifacts.require("deploy/deployNormsCooptationProcedure")
var normsCooptationProcedure = artifacts.require("procedures/normsCooptationProcedure")

// SimpleAdminNomination
var deploySimpleAdminsAndMasterNominationProcedure = artifacts.require("deploy/deploySimpleAdminsAndMasterNominationProcedure")
var simpleAdminsAndMasterNominationProcedure = artifacts.require("procedures/simpleAdminsAndMasterNominationProcedure")

// Simple Norm Nomination
var deploySimpleNormNominationProcedure = artifacts.require("deploy/deploySimpleNormNominationProcedure")
var simpleNormNominationProcedure = artifacts.require("procedures/simpleNormNominationProcedure")

// Vote on masters
var deployVoteOnAdminsAndMastersProcedure = artifacts.require("deploy/deployVoteOnAdminsAndMastersProcedure")
var voteOnAdminsAndMastersProcedure = artifacts.require("procedures/voteOnAdminsAndMastersProcedure")
// Vote on expense
var deployVoteOnExpenseProcedure = artifacts.require("deploy/deployVoteOnExpenseProcedure")
var voteOnExpenseProcedure = artifacts.require("procedures/voteOnExpenseProcedure")
// Vote on member addition
var deployVoteOnNormsProcedure = artifacts.require("deploy/deployVoteOnNormsProcedure")
var voteOnNormsProcedure = artifacts.require("procedures/voteOnNormsProcedure")

module.exports = function(deployer, network, accounts) {

  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("Testing all currently implemented procedures and stat display")
  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("-------------------------------------")
  console.log("Available accounts : ")
  accounts.forEach((account, i) => console.log("-", account))
  console.log("-------------------------------------")
  console.log("Initial balance:")
  console.log(web3.eth.getBalance(accounts[0]).toString(10))
  console.log("-------------------------------------")
  console.log("Deploying Organ")
  // 3 organs to deploy: Members list, presidential organ, moderators organ, admins organ
  deployer.deploy(deployOrgan, "Member Organ", {from: accounts[0]}).then(() => {
  const memberRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy second organ (president registry)
  deployer.deploy(deployOrgan, "Presidential Organ", {from: accounts[0]}).then(() => {
  const presidentRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy third organ (Moderators)
  deployer.deploy(deployOrgan, "Moderators Organ", {from: accounts[0]}).then(() => {
  const moderatorsOrgan = Organ.at(deployOrgan.address)
  // Deploy Fourth organ (admins)
  deployer.deploy(deployOrgan, "Admins Organ", {from: accounts[0]}).then(() => {
  const adminOrgan = Organ.at(deployOrgan.address)

    console.log("-------------------------------------")
    console.log("Deploying Procedures")
    // Deploying 9 procedures: 
    // Cyclical ManyToOne
    // Cyclical ManyToMany
    // Deposit Funds procedure
    // Cooptation
    // SimpleAdminNomination
    // Simple Norm Nomination
    // Vote on masters
    // Vote on expense
    // Vote on member addition

    // Voting time variables. These are short for demonstration purposes
    voteDurationInSeconds = 180

    // Deploy presidential election procedure
    deployer.deploy(deployCyclicalManyToOneElectionProcedure, memberRegistryOrgan.address, presidentRegistryOrgan.address , "Presidential election", {from: accounts[0]}).then(() => {
    const presidentialElection = cyclicalManyToOneElectionProcedure.at(deployCyclicalManyToOneElectionProcedure.address)

    // Deploy Moderators election procedure
    deployer.deploy(deployCyclicalManyToManyElectionProcedure, memberRegistryOrgan.address, moderatorsOrgan.address,  "Moderators election", {from: accounts[0]}).then(() => {
    const moderatorsElection = cyclicalManyToManyElectionProcedure.at(deployCyclicalManyToManyElectionProcedure.address)
    
    // Deploy deposit procedure
    deployer.deploy(deployDepositFundsProcedure, 0x0000, adminOrgan.address, memberRegistryOrgan.address, "Depositing", {from: accounts[0]}).then(() => {
    const depositFunds = depositFundsProcedure.at(deployDepositFundsProcedure.address)

    // Deploy Cooptation
    deployer.deploy(deployNormsCooptationProcedure, memberRegistryOrgan.address, adminOrgan.address , presidentRegistryOrgan.address, 10, voteDurationInSeconds, voteDurationInSeconds, "Cooptation",{from: accounts[0]}).then(() => {
    const cooptationProcedure = normsCooptationProcedure.at(deployNormsCooptationProcedure.address)

    // Deploy admin nomination
    deployer.deploy(deploySimpleAdminsAndMasterNominationProcedure, adminOrgan.address, "Admin Master Nomination", {from: accounts[0]}).then(() => {
    const simpleAdminNomination = simpleAdminsAndMasterNominationProcedure.at(deploySimpleAdminsAndMasterNominationProcedure.address)

    // Deploy simple nomination procedure
    deployer.deploy(deploySimpleNormNominationProcedure, adminOrgan.address, "Norm Nomination", {from: accounts[0]}).then(() => {
    const simpleNormNomination = simpleNormNominationProcedure.at(deploySimpleNormNominationProcedure.address)

    // Deploy constitutionnal reform procedure
    deployer.deploy(deployVoteOnAdminsAndMastersProcedure, memberRegistryOrgan.address, adminOrgan.address, presidentRegistryOrgan.address, 10, voteDurationInSeconds, voteDurationInSeconds, 66, "Constitutional reform", {from: accounts[0]}).then(() => {
    const constitutionnalReform = voteOnAdminsAndMastersProcedure.at(deployVoteOnAdminsAndMastersProcedure.address)

    // Deploy Vote on expense
    deployer.deploy(deployVoteOnExpenseProcedure, memberRegistryOrgan.address, memberRegistryOrgan.address, adminOrgan.address,  presidentRegistryOrgan.address, 10, voteDurationInSeconds, voteDurationInSeconds, 50, "Vote on expenses", {from: accounts[0]}).then(() => {
    const voteOnExpense = voteOnExpenseProcedure.at(deployVoteOnExpenseProcedure.address)
   
    // Deploy Vote on norms
    deployer.deploy(deployVoteOnNormsProcedure, memberRegistryOrgan.address, moderatorsOrgan.address, adminOrgan.address , presidentRegistryOrgan.address, 10, voteDurationInSeconds, voteDurationInSeconds, 50, "Members list management", {from: accounts[0]}).then(() => {
    const memberManagement = voteOnNormsProcedure.at(deployVoteOnNormsProcedure.address)
      console.log("-------------------------------------")
      console.log("Crediting masters")
      // SimpleAdminNomination
      // Vote on masters
      presidentRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutional reform", {from: accounts[0]}).then(() => {
      moderatorsOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutional reform", {from: accounts[0]}).then(() => {
      memberRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutional reform", {from: accounts[0]}).then(() => {
      adminOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutional reform", {from: accounts[0]}).then(() => {
      adminOrgan.addMaster(simpleAdminNomination.address, true, true, "Admin nomination", {from: accounts[0]}).then(() => {

        console.log("-------------------------------------")
        console.log("Crediting admins")
        // Cyclical ManyToOne
        // Cyclical ManyToMany
        // Deposit Funds procedure
        // Cooptation
        // Simple Norm Nomination
        // Vote on masters
        // Vote on expense
        // Vote on member addition

        presidentRegistryOrgan.addAdmin(presidentialElection.address, true, true, false, false, "PresElec", {from: accounts[0]}).then(() => {
        moderatorsOrgan.addAdmin(moderatorsElection.address, true, true, false, false, "ModElec", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(depositFunds.address, false, false, true, true, "Deposit", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(cooptationProcedure.address, true, false, true, true, "Cooptation", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(simpleNormNomination.address, true, true, false, false, "Norm Nomination", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(voteOnExpense.address, false, false, false, true, "Vote on Expense", {from: accounts[0]}).then(() => {
        memberRegistryOrgan.addAdmin(memberManagement.address, true, true, false, false, "Voting on norms", {from: accounts[0]}).then(() => {

        // Temp admin, in order to add members

        memberRegistryOrgan.addAdmin(accounts[0], true, true, false, false, "Temp admin", {from: accounts[0]}).then(() => {
        adminOrgan.addAdmin(accounts[0], true, true, false, false, "Temp admin", {from: accounts[0]}).then(() => {
         
          console.log("-------------------------------------")
          console.log("Crediting norms")
          memberRegistryOrgan.addNorm(accounts[1], "Member 1", 1, 1, 1, {from: accounts[0]}).then(() => {
          adminOrgan.addNorm(accounts[0], "Member 0", 1, 1, 1, {from: accounts[0]}).then(() => {

            console.log("-------------------------------------")
            console.log("Removing temp admins")
            memberRegistryOrgan.remAdmin(accounts[0], {from: accounts[0]}).then(() => {
            adminOrgan.remAdmin(accounts[0], {from: accounts[0]}).then(() => {

              console.log("-------------------------------------")
              console.log("Removing temp masters")
              memberRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              presidentRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              moderatorsOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              adminOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {


                      console.log("-------------------------------------")
                      console.log("Put these new addresses in settings :")
                      console.log("  \"organs_addresses\": [")
                      console.log("    \""+memberRegistryOrgan.address+"\",  // (Members)")
                      console.log("    \""+presidentRegistryOrgan.address+"\",  // (President)")
                      console.log("    \""+moderatorsOrgan.address+"\",  // (Moderators)")
                      console.log("    \""+adminOrgan.address+"\",  // (Admins)")
                      console.log("  ],")
                      console.log("  \"procedures_addresses\": [")

                      console.log("    \""+presidentialElection.address+"\",  // (Presidential Election)")
                      console.log("    \""+moderatorsElection.address+"\",  // (Moderators Election)")
                      console.log("    \""+depositFunds.address+"\",  // (depositFunds)")
                      console.log("    \""+cooptationProcedure.address+"\",  // (cooptationProcedure)")
                      console.log("    \""+simpleAdminNomination.address+"\",  // ( simpleAdminNomination)")
                      console.log("    \""+simpleNormNomination.address+"\",  // (simpleNormNomination)")
                      console.log("    \""+constitutionnalReform.address+"\",  // (constitutionnalReform)")
                      console.log("    \""+moderatorsElection.address+"\",  // (voteOnExpense)")
                      console.log("    \""+voteOnExpense.address+"\",  // (Vote On Norms)")
                      console.log("  ]")
                      console.log("Accounts 0 has been added as members")
                      console.log("-------------------------------------")




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
                                                                          


  // Use deployer to state migration tasks.
};
