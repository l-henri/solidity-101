

/// Importing required contracts
// Organs
var deployOrgan = artifacts.require("deployOrgan")
var Organ = artifacts.require("Organ")
// Presidential election
var deployCyclicalManyToOneElectionProcedure = artifacts.require("deploy/deployCyclicalManyToOneElectionProcedure")
var cyclicalManyToOneElectionProcedure = artifacts.require("procedures/cyclicalManyToOneElectionProcedure")
// Moderators election
var deployCyclicalManyToManyElectionProcedure = artifacts.require("deploy/deployCyclicalManyToManyElectionProcedure")
var cyclicalManyToManyElectionProcedure = artifacts.require("procedures/cyclicalManyToManyElectionProcedure")

module.exports = function(deployer, network, accounts) {

  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("Testing stats display on cyclicalManyToManyElectionProcedure and cyclicalManyToOneElectionProcedure")
  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("-------------------------------------")
  console.log("Available accounts : ")
  accounts.forEach((account, i) => console.log("-", account))
  console.log("-------------------------------------")
  console.log("Initial balance:")
  console.log(web3.eth.getBalance(accounts[0]).toString(10))
  console.log("-------------------------------------")
  console.log("Deploying Organ")
  // 3 organs to deploy: Members list
  deployer.deploy(deployOrgan, "Member Organ", {from: accounts[0]}).then(() => {
  const memberRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy second organ (president registry)
  deployer.deploy(deployOrgan, "Presidential Organ", {from: accounts[0]}).then(() => {
  const presidentRegistryOrgan = Organ.at(deployOrgan.address)
  // Deploy third organ (admins)
  deployer.deploy(deployOrgan, "Moderators Organ", {from: accounts[0]}).then(() => {
  const moderatorsOrgan = Organ.at(deployOrgan.address)

    console.log("-------------------------------------")
    console.log("Deploying Procedures")
    // Deploying 4 procedures: 
    // * Vote on adding/excluding members
    // * Vote on changing constitution
    // * Vote on expense
    // * Deposit procedure
    // Voting time variables. These are short for demonstration purposes
    voteDurationInSeconds = 10

    // Deploy presidential election procedure
    deployer.deploy(deployCyclicalManyToOneElectionProcedure, memberRegistryOrgan.address, presidentRegistryOrgan.address , "Presidential election", {from: accounts[0]}).then(() => {
    const presidentialElection = cyclicalManyToOneElectionProcedure.at(deployCyclicalManyToOneElectionProcedure.address)
    // Deploy Moderators election procedure
    deployer.deploy(deployCyclicalManyToManyElectionProcedure, memberRegistryOrgan.address, moderatorsOrgan.address,  "Moderators election", {from: accounts[0]}).then(() => {
    const moderatorsElection = cyclicalManyToManyElectionProcedure.at(deployCyclicalManyToManyElectionProcedure.address)

        console.log("-------------------------------------")
        console.log("Crediting admins")

        presidentRegistryOrgan.addAdmin(presidentialElection.address, true, true, false, false, "PresElec", {from: accounts[0]}).then(() => {
        moderatorsOrgan.addAdmin(moderatorsElection.address, true, true, false, false, "ModElec", {from: accounts[0]}).then(() => {
        // Temp admin, in order to add members
        memberRegistryOrgan.addAdmin(accounts[0], true, true, false, false, "Temp admin", {from: accounts[0]}).then(() => {
          console.log("-------------------------------------")
          console.log("Crediting norms")
          memberRegistryOrgan.addNorm(accounts[0], "Member 0", 1, 1, 1, {from: accounts[0]}).then(() => {

            console.log("-------------------------------------")
            console.log("Removing temp admins")
            memberRegistryOrgan.remAdmin(accounts[0], {from: accounts[0]}).then(() => {
              console.log("-------------------------------------")
              console.log("Removing temp masters")
              memberRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              presidentRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {
              moderatorsOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {


                      console.log("-------------------------------------")
                      console.log("Put these new addresses in settings :")
                      console.log("  \"organs_addresses\": [")
                      console.log("    \""+memberRegistryOrgan.address+"\",  // (Members)")
                      console.log("    \""+presidentRegistryOrgan.address+"\",  // (President)")
                      console.log("    \""+moderatorsOrgan.address+"\",  // (Moderators)")
                      console.log("  ],")
                      console.log("  \"procedures_addresses\": [")
                      console.log("    \""+presidentialElection.address+"\",  // (Presidential Election)")
                      console.log("    \""+moderatorsElection.address+"\",  // (Moderators Election)")
                      console.log("  ]")
                      console.log("Accounts 0 has been added as members")
                      console.log("-------------------------------------")





                      console.log("Testing Elections")
                      presidentialElection.createBallot("Test Pres", {from: accounts[0]}).then(() => {
                      moderatorsElection.createBallot("Test Mods", {from: accounts[0]}).then(() => {
                        presidentialElection.presentCandidacy(0, "Henri", 0,0,0, {from: accounts[0]}).then(() => {
                        moderatorsElection.presentCandidacy(0, "Henri", 0,0,0, {from: accounts[0]}).then(() => {
                          console.log("Waiting for voting period...")
                          setTimeout(() => {
                            console.log("Done. Voting")
                            presidentialElection.vote(0, accounts[0], {from: accounts[0]}).then(() => {
                            moderatorsElection.vote(0, [accounts[0]], {from: accounts[0]}).then(() => {
                              console.log("Waiting for counting period...")
                              setTimeout(() => {
                              console.log("Done. Counting")
                              presidentialElection.endBallot(0, {from: accounts[0]}).then(() => {
                              moderatorsElection.endBallot(0, {from: accounts[0]}).then(() => {

                              console.log("Getting Stats:")
                              presidentialElection.getCandidateVoteNumber(0, accounts[0],{from: accounts[0]}).then(stats1 => {
                              moderatorsElection.getCandidateVoteNumber(0,  accounts[0], {from: accounts[0]}).then(stats2 => {
                              console.log(stats1)
                              console.log(stats2)

                        //      console.log("Done. Enforcing")
                        //      presidentialElection.enforceBallot(0, {from: accounts[0]}).then(() => {
                        //      moderatorsElection.enforceBallot(0, {from: accounts[0]}).then(() => {

                        //      console.log("Getting Stats:")
                        //      presidentialElection.getCandidateVoteNumber(0, accounts[0],{from: accounts[0]}).then(stats1 => {
                        //      moderatorsElection.getCandidateVoteNumber(0, accounts[0], {from: accounts[0]}).then(stats2 => {
                        //      console.log(stats1)
                        //      console.log(stats2)

                      //  }) // Getting stats V2
                      //  }) // Getting stats V2
                      //  }) // Enforcing Mods
                      //  }) // Enforcing  pres

                        }) // Getting stats V1
                        }) // Getting stats V1

                        }) // Couting Mods
                        }) // Couting  pres
                        }, (voteDurationInSeconds+1)*1000) // Counting timeout
                        }) // Voting Mods
                        }) // Voting  pres
                        }, (voteDurationInSeconds+1)*1000) // Voting timeout
                        }) // Candidacy Mods
                        }) // Candidacy Pres
                        
                        }) // Create Ballot Mods
                        }) // Create Ballot Pres

                      //   }) // Get Norm Number
                      //   }) // End proposition
                      //   }) //Voting
                      //   }) // Proposition creation transaction
                      // }) // Deposit transaction


                      // console.log(web3.eth.getBalance(memberRegistryOrgan.address).toString(10))
                      
                      //   depositFunds.sendTransaction({from: accounts[0], value: 1000000000}).then(() => {
                      //   console.log(web3.eth.getBalance(memberRegistryOrgan.address).toString(10))
                        
                      //   console.log("Testing Withdrawals")
                      //   voteOnExpense.createProposition(accounts[1], 1000, 1, 1, 1, "Test", {from: accounts[0]}).then(() => {
                      //   voteOnExpense.vote(0, true, {from: accounts[0]}).then(() => {
                      //   setTimeout(() => {
                      //   voteOnExpense.endPropositionVote(0, {from: accounts[0]}).then(() => {
                      //   console.log(web3.eth.getBalance(memberRegistryOrgan.address).toString(10))
                        
                      //   memberRegistryOrgan.getActiveNormNumber().then(normNumber => {
                      //   console.log(normNumber)
                        
                      //   voteOnExpense.getVotedPropositionResults(0).then(QueryResult => {
                      //   console.log(QueryResult)
                      //   voteOnExpense.getPropositionStatus(0).then(QueryResult => {
                      //   console.log(QueryResult)
                      //   voteOnExpense.getVotedPropositionStats(0).then(QueryResult => {
                      //   console.log(QueryResult)
                      //   console.log("promulgateProposition")
                      //   voteOnExpense.promulgateProposition(0, true, {from: accounts[0]}).then(() => {

                      //   console.log(web3.eth.getBalance(accounts[1]).toString(10))

                      //   }) // Promulgation
                      //   }) // Query election stats
                      //   }) // Query Election results
                      //   }) // Query status
                      //   }) // Get Norm Number
                      //   }) // End proposition
                      //   }, (voteDurationInSeconds+1)*1000) // Timeout
                      //   }) //Voting
                      //   }) // Proposition creation transaction
                      // }) // Deposit transaction







                      // Set up end

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
