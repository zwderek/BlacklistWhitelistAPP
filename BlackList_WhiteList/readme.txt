truffle compile
truffle migrate --network sepolia

0xE422254A424fd7b25f8446891b722feB2E4544f6

truffle console --network sepolia
contract = await Token.at('0xE422254A424fd7b25f8446891b722feB2E4544f6')
await contract.getStatus('0x404B28830DB2f4005Da7e8602Bf5a0592Cf32A77')