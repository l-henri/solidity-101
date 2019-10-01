/// Importing required contracts
// Organs
var Organ = artifacts.require("Organ")



module.exports = function(deployer, network, accounts) {

  console.log("---------------------------------------------------------------------------------------------------------------")
  console.log("Testing Authentication through organs")
  console.log("---------------------------------------------------------------------------------------------------------------")
/*  console.log("-------------------------------------")
  console.log("Available accounts : ")
  accounts.forEach((account, i) => console.log("-", account))
  console.log("-------------------------------------")*/
  console.log("-------------------------------------")
  console.log("Deploying Organ")
  // 1 organs to deploy: Members list
  deployer.deploy(Organ, "Member Organ", {from: accounts[0]}).then(() => {
  const memberRegistryOrgan = Organ.at(Organ.address)
    console.log("-------------------------------------")



  })

  // Use deployer to state migration tasks.
};
