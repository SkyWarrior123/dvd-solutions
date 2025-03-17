🚀 Damn Vulnerable DeFi (DVD) - Solutions to Security Challenges

Welcome to Damn Vulnerable DeFi (DVD) Solutions, a smart contract security playground where developers, security researchers, and educators can test, audit, and exploit vulnerabilities in realistic DeFi scenarios.

Perhaps the most sophisticated set of vulnerable Solidity smart contracts ever witnessed, this project features flash loans, price oracles, governance exploits, NFTs, DEX manipulation, lending pools, smart contract wallets, upgradeability flaws, and much more.

## 🛠 Why DVD?

✅ Sharpen your auditing and bug-hunting skills  
✅ Detect, test, and fix security flaws in realistic smart contract environments  
✅ Benchmark smart contract security tooling  
✅ Create educational content (articles, tutorials, talks, CTFs, and courses)  

---

## 🚀 Challenges

Each challenge is designed to exploit a critical vulnerability in a smart contract, breaking its invariants and showcasing real-world attack vectors.

| Challenge       | Exploit Type                           | Broken Invariant                |
|---------------|----------------------------------|---------------------------------|
| Unstoppable   | Flash loan disruption            | Pool balance consistency       |
| NaiveReceiver | Fee drain attack                 | User-controlled transactions   |
| Truster       | Arbitrary call execution         | Access control of approvals    |
| SideEntrance  | Flash loan with deposit trick    | Loan repayment tracking        |
| TheRewarder   | Reward timing manipulation       | Fair reward distribution       |
| Selfie        | Governance takeover with flash loans | Genuine governance participation |
| Compromised   | Oracle key leak                  | Oracle price integrity         |
| Backdoor      | Malicious initialization         | Unauthorized access            |
| Climber       | Upgradeability exploit           | Unauthorized contract changes  |
| Free-Rider    | NFT arbitrage                    | Improper ownership validation  |
| Wallet-Mining | Predictable wallet generation    | Address brute-forcing          |
| Withdrawal    | Reentrancy vulnerability         | Incorrect balance accounting   |
| Shards        | Mismanagement of multi-signature wallets | Unauthorized fund access |
| Puppet        | Price manipulation               | Improper price oracle reliance |
| Puppet-V2     | Improved price manipulation      | Manipulated liquidity pools    |
| Puppet-V3     | Flash loan price manipulation    | Lending pool vulnerability     |
| The-Rewarder  | Reward farming attack            | Unfair reward distribution     |
| Truster       | Unchecked delegate calls         | Privileged function execution  |
| Selfie        | Governance exploitation          | Governance security breach     |
| Side-Entrance | Unauthorized lending pool usage  | Loan repayment exploitation    |
| The-Rewarder  | Excessive token farming          | Token distribution logic flaw  |
| Curvy-Puppet  | LP token exploitation            | Manipulated price feeds        |

---

## 📏 Invariants & Security Considerations

Smart contracts rely on invariants to ensure correctness and security. This repository explores how breaking these invariants leads to financial losses.

| Category              | Invariant                                      | Broken in                        |
|----------------------|----------------------------------------------|--------------------------------|
| Balance Consistency  | Pool balance should match recorded deposits  | Unstoppable, SideEntrance     |
| Access Control       | Only privileged roles can execute key functions | Truster, Selfie, Backdoor     |
| Oracle Integrity     | Price feeds should be tamper-proof           | Compromised, Puppet, Puppet-V2, Puppet-V3 |
| State Consistency    | Loan repayments must be correctly tracked    | NaiveReceiver, SideEntrance   |
| Governance Security  | Voting should require genuine ownership      | Selfie                        |
| Fair Reward Distribution | Rewards should be evenly distributed | TheRewarder                   |
| Upgradeability       | Only authorized upgrades should occur        | Climber                        |
| NFT Security        | Ownership and transfers should be enforced   | Free-Rider                     |
| Wallet Security     | Wallet addresses should not be predictable   | Wallet-Mining                  |
| Reentrancy Protection | Functions should not allow unexpected reentry | Withdrawal                   |

---

## 🧪 Tests & Project Structure

Each challenge has dedicated test cases in Foundry to validate exploits.

### 📁 Project Structure

```
.
├── contracts/
│   ├── Unstoppable.sol
│   ├── NaiveReceiver.sol
│   ├── Truster.sol
│   ├── SideEntrance.sol
│   ├── TheRewarder.sol
│   ├── Selfie.sol
│   ├── Compromised.sol
│   ├── Backdoor.sol
│   ├── Climber.sol
│   ├── Free-Rider.sol
│   ├── Wallet-Mining.sol
│   ├── Withdrawal.sol
│   ├── Shards.sol
│   ├── Puppet.sol
│   ├── Puppet-V2.sol
│   ├── Puppet-V3.sol
│   ├── Curvy-Puppet.sol
├── tests/
│   ├── unstoppable/Unstoppable.t.sol
│   ├── naive-receiver/NaiveReceiver.t.sol
│   ├── truster/Truster.t.sol
│   ├── side-entrance/SideEntrance.t.sol
│   ├── the-rewarder/TheRewarder.t.sol
│   ├── selfie/Selfie.t.sol
│   ├── compromised/Compromised.t.sol
│   ├── backdoor/Backdoor.t.sol
│   ├── climber/Climber.t.sol
│   ├── free-rider/FreeRider.t.sol
│   ├── wallet-mining/WalletMining.t.sol
│   ├── withdrawal/Withdrawal.t.sol
│   ├── shards/Shards.t.sol
│   ├── puppet/Puppet.t.sol
│   ├── puppet-v2/PuppetV2.t.sol
│   ├── puppet-v3/PuppetV3.t.sol
│   ├── curvy-puppet/CurvyPuppet.t.sol
└── README.md
```

Each test ensures the exploit successfully breaks the protocol.

---

## 📖 Solutions

The detailed solutions and proof-of-concepts (PoCs) for these challenges are available in the GitHub repository.

🔗 Check out the solutions and PoCs:  
👉 [https://github.com/SkyWarrior123/dvd-solutions/](https://github.com/SkyWarrior123/dvd-solutions/)

---

## 🚀 Getting Started

### 🔧 Installation

1️⃣ Clone the repository
```sh
git clone https://github.com/SkyWarrior123/dvd-solutions.git
cd dvd-solutions
```

2️⃣ Set up the environment
```sh
cp .env.sample .env
# Add a valid RPC URL for mainnet forking challenges
```

3️⃣ Install Foundry
```sh
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

4️⃣ Build the project
```sh
forge build
```

---

## 📌 Navigation in GitHub

Each challenge is structured with:

- A `README.md` inside `src/<challenge-name>/` explaining the vulnerability.
- A smart contract inside `src/<challenge-name>/` with the exploit target.
- A Foundry test inside `test/<challenge-name>/` to validate the exploit.

---

## Running test

To run all tests
- 
```sh
forge test
```
- To run specific test
```sh
forge test --match-path test/<challenge-folder>/<challenge-name>.sol
```

## 🔥 ONLY FOR EDUCATIONAL PURPOSES

📌 For more details, visit:  
👉 [https://github.com/SkyWarrior123/dvd-solutions/](https://github.com/SkyWarrior123/dvd-solutions/)

Stay secure! 🚀

