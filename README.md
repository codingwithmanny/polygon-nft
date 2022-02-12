# Polygon NFT

This is a sample project that shows how you can deploy an NFT contract that shows an SVG image.

---

## Requirements

- NVM or Node 16.14.0
- Yarn v1.22.17
- Metamask
- [Polygonscan Account](https://polygonscan.com/login) - For `POLYGONSCAN_API`
- [Alchemy Account](https://www.alchemy.com) - For `POLYGON_URL`

---

## Local Setup

For the purposes of local development make sure your wallet and configurations are set to a testnet.

### 1 - Install dependencies

```bash
yarn;
```

### 2 - Copy and fill in environment variables file

```bash
cp .env.example .env;
```

### 3 - Deploy

```bash
yarn deploy;
# copy contract address to clipboard
```

### 4 - Verify

```bash
yarn verify DEPLOYED_CONTRACT_ADDRESS;
```

---

## Wallet Setup

**NOTE** You will need Metamask for this part.

### 1 - Add Polygon Network Mumbai To Metamask

A. Go to [https://chainlist.org/](https://chainlist.org/) and search for `polygon`

B. Under **Mumbai**, Click on `Connect Wallet`

C. Once connected, Click on `Add To Metamask`

D. Once prompted, Click on `Approve`

E. Click on `Switch network`

### 2 - Add MATIC Tokens To Wallet

A. Go to [https://faucet.polygon.technology/](https://faucet.polygon.technology/)

B. Copy and paste your wallet address into the `Wallet Address` field with the **Network** set to `Mumbai` and **Select Token** set to `MATIC Token`. Then click on `Submit`

C. `Confirm` the prompt

D. Wait 1-2 minutes and you should an updated amount in your wallet for `0.X` amount of `MATIC`

**INFO:** You can also verify your balance on the network by going to `https://mumbai.polygonscan.com/address/YOUR_WALLET_ADDRESS`

---

## Alchemy Setup

A. Create a new account on [https://www.alchemy.com](https://www.alchemy.com)

B. Once in the Dashboard, click on `+ Create App`

C. Give it a **Name** and **Description**, set **Environment** to `Development`, set **Chain** to `Polygon`, set **Network** to `Polygon Mumbai`, 

D. Click `Create App`

E. Click on your newly created app name

F. In the app, click on `View Key` and copy to your clipboard the **HTTP** address

G. Paste that `HTTP` value into your `.env` file under `POLYGON_URL=`

---

## Polygonscan Setup

A. Create a new account on [https://polygonscan.com](polygonscan.com)

B. In [https://polygonscan.com/myaccount](https://polygonscan.com/myaccount) click on `API-KEYs`

C. Click on the `+Add` button and give it an `AppName`

D. Once created, copy to your clipboard the newly create `Api-Key Token` and paste it into your `.env` file under `POLYGONSCAN_API`

---

## Metamask Private Key

**NOTE:** `PRIVATE_KEY` (DO NOT SHARE WITH ANYONE) is your wallets private key for deployments.
If this is a development account, it's recommended you create a completely different wallet.

A. While in Chrome and Metamask is open to the address you would like the secret key to, click on the 3 dots (...)

B. In the dropdown click on `Account Details`

C. In **Account Details** click on `Export Private Key`

D. Enter your Metamask password and copy to your clipboard the private key and pates it into your `.env` file under `PRIVATE_KEY`

---

## Minting On Polygonscan

### 1 - Go To Contract Address

Go to https://mumbai.polygonscan.com/address/DEPLOYED_CONTRACT_ADDRES

### 2 - Mint NFT

A. Click on the `Write Contract` button

B. Click on `Connect to Web3` and connect in Metamask

C. Once connected, scroll down to the function `mintToken`

D. Enter `0.01` under **mintToken** and put a decimal value under the **tokenId**

**_Need to calculate a hex to decimal value?_**

Open your browser console and paste the following:

```js
parseInt('#ff00ff'.replace('#', ''), 16);
// Expected output:
// 16711935
```

E. Once the values are entered, click the `Write` button

### 3 - Validate Your Token

A. Back at the top of your contract click on `Read Contract`

B. Find the section called `tokenURI`, paste your decimal value under **tokenId**, and click `Query`

```js
// Example expected output:
// data:application/json;base64,eyJpZCI6IDY1MjgwLCAibmFtZSI6ICIjMDBGRjAwIiwgInRva2VuX25hbWUiOiAiTmZ0U3ZnIiwgInRva2VuX3N5bWJvbCI6ICJORlMiLCAiZGVzY3JpcHRpb24iOiAiQSBOZnQgU3ZnIiwgImJhY2tncm91bmRfY29sb3IiOiAiRkZGRkZGIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogImhleGFkZWNpbWFsIiwgInZhbHVlIjogIiMwMEZGMDAifV0sICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUF2UGp4eVpXTjBJSGs5SWpBaUlIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SWlNd01FWkdNREFpSUM4K1BDOXpkbWMrIn0=
```

C. Parse the results by running:

```bash
yarn parse --tokenURI="data:application/json;base64,eyJpZCI6IDY1MjgwLCAibmFtZSI6ICIjMDBGRjAwIiwgInRva2VuX25hbWUiOiAiTmZ0U3ZnIiwgInRva2VuX3N5bWJvbCI6ICJORlMiLCAiZGVzY3JpcHRpb24iOiAiQSBOZnQgU3ZnIiwgImJhY2tncm91bmRfY29sb3IiOiAiRkZGRkZGIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogImhleGFkZWNpbWFsIiwgInZhbHVlIjogIiMwMEZGMDAifV0sICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUF2UGp4eVpXTjBJSGs5SWpBaUlIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SWlNd01FWkdNREFpSUM4K1BDOXpkbWMrIn0="

# Expected output
# Parsing:
# "data:application/json;base64,eyJpZCI6IDY1MjgwLCAibmFtZSI6ICIjMDBGRjAwIiwgInRva2VuX25hbWUiOiAiTmZ0U3ZnIiwgInRva2VuX3N5bWJvbCI6ICJORlMiLCAiZGVzY3JpcHRpb24iOiAiQSBOZnQgU3ZnIiwgImJhY2tncm91bmRfY29sb3IiOiAiRkZGRkZGIiwgImF0dHJpYnV0ZXMiOiBbeyJ0cmFpdF90eXBlIjogImhleGFkZWNpbWFsIiwgInZhbHVlIjogIiMwMEZGMDAifV0sICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0OGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUF2UGp4eVpXTjBJSGs5SWpBaUlIZHBaSFJvUFNJeE1EQWxJaUJvWldsbmFIUTlJakV3TUNVaUlHWnBiR3c5SWlNd01FWkdNREFpSUM4K1BDOXpkbWMrIn0="
# {
#   id: 65280,
#   name: '#00FF00',
#   token_name: 'NftSvg',
#   token_symbol: 'NFS',
#   description: 'A Nft Svg',
#   background_color: 'FFFFFF',
#   attributes: [ { trait_type: 'hexadecimal', value: '#00FF00' } ],
#   image: 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiAvPjxyZWN0IHk9IjAiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiMwMEZGMDAiIC8+PC9zdmc+'
# }
```

D. Copy the json image value into your browser

```
data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaW5ZTWluIG1lZXQiIHZpZXdCb3g9IjAgMCAzNTAgMzUwIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiAvPjxyZWN0IHk9IjAiIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiMwMEZGMDAiIC8+PC9zdmc+
```





