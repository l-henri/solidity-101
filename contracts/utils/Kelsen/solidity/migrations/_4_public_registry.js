// 17h13




/// Importing required contracts
// Organs
var deployOrgan = artifacts.require("deployOrgan")
var Organ = artifacts.require("Organ")

// Vote on masters
var deployVoteOnAdminsAndMastersProcedure = artifacts.require("deploy/deployVoteOnAdminsAndMastersProcedure")
var voteOnAdminsAndMastersProcedure = artifacts.require("procedures/voteOnAdminsAndMastersProcedure")
// Vote on member addition
var deployVoteOnNormsProcedure = artifacts.require("deploy/deployVoteOnNormsProcedure")
var voteOnNormsProcedure = artifacts.require("procedures/voteOnNormsProcedure")


module.exports = function(deployer, network, accounts) {

  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("Deploying a public registry")
  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("-------------------------------------")
  console.log("Available accounts : ")
  accounts.forEach((account, i) => console.log("-", account))
  console.log("-------------------------------------")
  console.log("-------------------------------------")
  console.log("Deploying Organ")
  // 2 organs to deploy: Members list and public registry
  deployer.deploy(deployOrgan, "Member Organ", {from: accounts[0]}).then(() => {
  const memberRegistryOrgan = Organ.at(deployOrgan.address)

  deployer.deploy(deployOrgan, "Public Registry", {from: accounts[0]}).then(() => {
  const publicRegistryOrgan = Organ.at(deployOrgan.address)
    console.log("-------------------------------------")
    console.log("Deploying Procedures")
    // Deploying 3 procedures: 
    // * Vote on adding/excluding members
    // * Vote on adding/excluding public registry entries
    // * Vote on changing constitution
    // Voting time variables. These are short for demonstration purposes
    voteDurationInSeconds = 60*3
    
    // Deploy members list management
    deployer.deploy(deployVoteOnNormsProcedure, memberRegistryOrgan.address, memberRegistryOrgan.address, 0x0000 , memberRegistryOrgan.address, 40, voteDurationInSeconds, voteDurationInSeconds, 50, "Members list management", {from: accounts[0]}).then(() => {
    const memberManagement = voteOnNormsProcedure.at(deployVoteOnNormsProcedure.address)

    // Deploy members list management
    deployer.deploy(deployVoteOnNormsProcedure, publicRegistryOrgan.address, memberRegistryOrgan.address, 0x0000 , memberRegistryOrgan.address, 40, voteDurationInSeconds, voteDurationInSeconds, 50, "Public registry management", {from: accounts[0]}).then(() => {
    const publicRegistryManagement = voteOnNormsProcedure.at(deployVoteOnNormsProcedure.address)

    // Deploy constitutionnal reform procedure
    deployer.deploy(deployVoteOnAdminsAndMastersProcedure, memberRegistryOrgan.address, 0x0000, memberRegistryOrgan.address, 40, voteDurationInSeconds, voteDurationInSeconds, 66, "Constitutionnal reform", {from: accounts[0]}).then(() => {
    const constitutionnalReform = voteOnAdminsAndMastersProcedure.at(deployVoteOnAdminsAndMastersProcedure.address)

      console.log("-------------------------------------")
      console.log("Crediting masters")
      memberRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {
      publicRegistryOrgan.addMaster(constitutionnalReform.address, true, true, "Constitutionnal reform", {from: accounts[0]}).then(() => {

        console.log("-------------------------------------")
        console.log("Crediting admins")

        memberRegistryOrgan.addAdmin(memberManagement.address, true, true, false, false, "Member cooptation", {from: accounts[0]}).then(() => {
        publicRegistryOrgan.addAdmin(publicRegistryManagement.address, true, true, false, false, "Member cooptation", {from: accounts[0]}).then(() => {
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
              publicRegistryOrgan.remMaster(accounts[0], {from: accounts[0]}).then(() => {


                      // Set up is ready
                console.log("Test name display")
                memberManagement.getProcedureName().then(myInfos1 => {
                constitutionnalReform.getProcedureName().then(myInfos2 => {
                publicRegistryManagement.getProcedureName().then(myInfos3 => {
                    console.log(myInfos1)
                    console.log(myInfos2)
                    console.log(myInfos3)

                      console.log("-------------------------------------")
                      console.log("Put these new addresses in settings :")
                      console.log("  \"organs_addresses\": [")
                      console.log("    \""+memberRegistryOrgan.address+"\",  // (Members)")
                      console.log("    \""+publicRegistryOrgan.address+"\",  // (Public registry)")
                      console.log("  ],")
                      console.log("  \"procedures_addresses\": [")
                      console.log("    \""+memberManagement.address+"\",  // (Member management)")
                      console.log("    \""+publicRegistryManagement.address+"\",  // (Public registry management)")
                      console.log("    \""+constitutionnalReform.address+"\",  // (Constitutionnal reform)")
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
})})})


  // Use deployer to state migration tasks.
};
