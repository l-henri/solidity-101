// Organs
var Organ = artifacts.require("Organ")
var OrganLib = artifacts.require("./libraries/organLibrary")

async function doDeploy(deployer, network, accounts) {
    await deployer.deploy(OrganLib);
    await deployer.link(OrganLib, [Organ]);
    testOrgan = await Organ.new("testOrgan");
}
module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await doDeploy(deployer, network);
    });
};
