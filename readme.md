# Repo of Team TBD
...tackling blockchain dilemmas...

well, i had problems with the whitelist-class ....i think because it does not have an constructor truffle's behavior was funny. now i changed the migration.js - please change the whitelist-contract.

greetings from the hackothon-night in motel one :-)


## Requirements:
https://docs.google.com/spreadsheets/d/1LCiIXgi5h1v5nsZqfzUiQbFVnukMZWMOC-svTEgiKvA/edit?usp=sharing

## Slides:
https://docs.google.com/presentation/d/1QzDG_8U8dBr2C6yyaqbmQecZeRXTv7T0gejqYn9PS6c/edit?usp=sharing

## Achievements (from the specs):
### REQUIREMENTS:
- [x] MUST use an ERC-20 compatible token for your STO
- [x] MUST be able to perform forced transfers for legal actions
- [x] MUST use an on-chain whitelist for investors
- [x] MUST enable to mint/burn tokens
- [x] MUST offer an on-chain solution to purchase (and sell back) tokens

### LIMITS:
- [x] You are not allowed to raise more than 50,000,000 € (= 50,000,000 token)
- [x] Minimal buy-in is 1000 tokens (only relevant for initial buy)

### INVESTORS:
- [x] The issuer mints/burns tokens based on the investments.
- [x] An investor wants to buy only 500 tokens but must buy at least 1000 tokens.
- [x] An Investor tries to sell tokens but is not allowed to do so before holding it X days (these days should be a variable that you can update). Asset freezing.
