// IMPORTS
// ----------------------------------------

// DEPLOY SCRIPT
// ----------------------------------------
const deployContract = async () => {
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying contracts with the account:",
    deployer.address
  );

  const NftSvgNFT = await ethers.getContractFactory("NftSvg");
  const nftSvgNFT = await NftSvgNFT.deploy();
  await nftSvgNFT.deployed();
  // This solves the bug in Mumbai network where the contract address is not the real one
  const txHash = nftSvgNFT.deployTransaction.hash;
  const txReceipt = await hre.ethers.provider.waitForTransaction(txHash);
  const contractAddress = txReceipt.contractAddress;
  console.log("Contract deployed to address:", contractAddress);
};

// INIT
// ----------------------------------------
deployContract()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1);
});