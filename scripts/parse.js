const yargs = require('yargs/yargs')
const { hideBin } = require('yargs/helpers')
const argv = yargs(hideBin(process.argv)).argv;

(() => {
  if(!argv?.tokenURI) {
    console.error('Error: invalid --tokenURI');
    return;
  }
  console.log(`Parsing:\n"${argv.tokenURI}"`)
  
  const tokenURI = argv.tokenURI.replace('data:application/json;base64,', '');
  const base64 = tokenURI.replace(/-/g, '+').replace(/_/g, '/');
  const jsonPayload = decodeURIComponent(
    Buffer.from(base64, 'base64')
      .toString()
      .split('')
      .map((c) => {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
      })
      .join(''),
  );

  console.log(JSON.parse(jsonPayload));
})()