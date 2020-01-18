const Migrations = artifacts.require("Migrations");
const Check = artifacts.require("checkpoint");
const Whitelist = artifacts.require("Whitelist");
const BondsContract = artifacts.require("BondsContract")



var rc;


const konto1 = '0x48E3c1F06b3dbE6bfe9591a354Dd0b0Ffa6b0a7e';
const konto2 = '0x1e9F566a321b18039c167E4b7b02377f18C0A041';
const konto3 = '0x43226e185d3cF7906Dc7c90cc51D43e7606E7dC3';
const konto4 = '0xeF482B3C2BeF6262c6D685537a03f6c3bb8732D3';
const konto5 = '0xcC640935137688d018C48820c9177f7969E15B98';
const konto6 = '0x21bDAE54271beA0309A9905f7751d2fdAb408AE9';
const konto7 = '0xDa68002f5c89b324A9De2CaE04F4b6865Ec4051F';
const konto8 = '0x3d4bb1eA2367d5Ea6F1b786AED3c20f39dA1601B';

module.exports = async function(deployer) {
  
  await deployer.deploy(Migrations);

  konten=new Array();
   konten[0] = '0x48E3c1F06b3dbE6bfe9591a354Dd0b0Ffa6b0a7e';
   konten[1] = '0x1e9F566a321b18039c167E4b7b02377f18C0A041';
   konten[2] = '0x43226e185d3cF7906Dc7c90cc51D43e7606E7dC3';
   konten[3] = '0xeF482B3C2BeF6262c6D685537a03f6c3bb8732D3';
   konten[4] = '0xcC640935137688d018C48820c9177f7969E15B98';
   konten[5] = '0x21bDAE54271beA0309A9905f7751d2fdAb408AE9';
   konten[6] = '0xDa68002f5c89b324A9De2CaE04F4b6865Ec4051F';
   konten[7] = '0x3d4bb1eA2367d5Ea6F1b786AED3c20f39dA1601B';


   kandidaten=new Array();
   konten[0] = '0x48E3c1F06b3dbE6bfe9591a354Dd0b0Ffa6b0a7e';
   konten[1] = '0x1e9F566a321b18039c167E4b7b02377f18C0A041';

  console.log("<<< checkpoint >>>");  
  let a = await deployer.deploy(Check);
  value = await a.check();
  console.log("Check Adresse:" + value);


  console.log("<<< whitelist >>>");  
  let wl = await deployer.deploy(Whitelist);
  value = await wl.gibAnzahl();
  console.log("Whitelist:" + value[0]);


  //
  // Testcase Whitelist Management
  //
  rc="-";
  console.log("Konto " + konto1 + " auf der Whitelist ?");  
  console.log("<<< zustand 1 >>>");  
  rc = await wl.isWhitelisted(konto1);
  console.log("RC:" + rc);

  console.log("..... auf der whitelist ergänzen.....");  
  rc = await wl.addToWhitelist(konten);

  console.log("<<< zustand 2 >>>");  
  rc = await wl.isWhitelisted(konto1);
  console.log("RC:" + rc);

  console.log("..... von der whitelist entfernen.....");  
  rc = await wl.removeFromWhitelist(konten);

  console.log("<<< zustand 3 >>>");  
  rc = await wl.isWhitelisted(konto1);
  console.log("RC:" + rc);



};

