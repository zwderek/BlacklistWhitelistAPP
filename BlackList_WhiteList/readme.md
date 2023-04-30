## Truffle Project

### Deploy
```
truffle compile
truffle migrate --network sepolia
```


current contract address:
    0xE422254A424fd7b25f8446891b722feB2E4544f6
exchange rate: 1
owner default token: 100000

### Console
```
truffle console --network sepolia
contract = await Token.at('0xE422254A424fd7b25f8446891b722feB2E4544f6')
```

```
await contract.transfer('0x404B28830DB2f4005Da7e8602Bf5a0592Cf32A77', 100)
await contract.getBalance('0x404B28830DB2f4005Da7e8602Bf5a0592Cf32A77')
```