# 🚀 Damn Vulnerable DeFi (DVD) - Security Challenges  

Welcome to **Damn Vulnerable DeFi (DVD) Solutions**, a smart contract security playground where developers, security researchers, and educators can test, audit, and exploit vulnerabilities in **realistic DeFi scenarios**.

Perhaps the most sophisticated **set of vulnerable Solidity smart contracts** ever witnessed, this project features **flash loans, price oracles, governance exploits, NFTs, DEX manipulation, lending pools, smart contract wallets, upgradeability flaws**, and much more.

## 🛠 Why DVD?  

✅ **Sharpen your auditing and bug-hunting skills**  
✅ **Detect, test, and fix security flaws** in realistic smart contract environments  
✅ **Benchmark smart contract security tooling**  
✅ **Create educational content** (articles, tutorials, talks, CTFs, and courses)  

---

## 🗂 Table of Contents  

- [🚀 Challenges](#-challenges)  
- [📏 Invariants & Security Considerations](#-invariants--security-considerations)  
- [🧪 Tests & Project Structure](#-tests--project-structure)  
- [📖 Solutions](#-solutions)  
- [🚀 Getting Started](#-getting-started)  
- [📌 Navigation in GitHub](#-navigation-in-github)  
- [🤝 Contributing](#-contributing)  
- [📜 License](#-license)  

---

## 🚀 Challenges  

Each challenge is designed to **exploit a critical vulnerability** in a smart contract, breaking its invariants and showcasing **real-world attack vectors**.

| **Challenge**    | **Exploit Type**                 | **Broken Invariant** |
|-----------------|---------------------------------|----------------------|
| **Unstoppable** | Flash loan disruption           | Pool balance consistency |
| **NaiveReceiver** | Fee drain attack              | User-controlled transactions |
| **Truster** | Arbitrary call execution          | Access control of approvals |
| **SideEntrance** | Flash loan with deposit trick | Loan repayment tracking |
| **TheRewarder** | Reward timing manipulation     | Fair reward distribution |
| **Selfie** | Governance takeover with flash loans | Genuine governance participation |
| **Compromised** | Oracle key leak                | Oracle price integrity |

---

## 📏 Invariants & Security Considerations  

Smart contracts rely on **invariants** to ensure correctness and security. This repository explores **how breaking these invariants leads to financial losses**.

| **Category**       | **Invariant** | **Broken in** |
|-------------------|-------------|--------------|
| **Balance Consistency** | Pool balance should match recorded deposits | Unstoppable, SideEntrance |
| **Access Control** | Only privileged roles can execute key functions | Truster, Selfie |
| **Oracle Integrity** | Price feeds should be tamper-proof | Compromised |
| **State Consistency** | Loan repayments must be correctly tracked | NaiveReceiver, SideEntrance |
| **Governance Security** | Voting should require genuine ownership | Selfie |
| **Fair Reward Distribution** | Rewards should be evenly distributed | TheRewarder |

---

## 🧪 Tests & Project Structure  

Each challenge has **dedicated test cases** in **Foundry** to validate exploits.  

### 📁 Project Structure  

. ├── contracts/ │ ├── Unstoppable.sol │ ├── NaiveReceiver.sol │ ├── Truster.sol │ ├── SideEntrance.sol │ ├── TheRewarder.sol │ ├── Selfie.sol │ ├── Compromised.sol ├── tests/ │ ├── unstoppable/Unstoppable.t.sol │ ├── naive-receiver/NaiveReceiver.t.sol │ ├── truster/Truster.t.sol │ ├── side-entrance/SideEntrance.t.sol │ ├── the-rewarder/TheRewarder.t.sol │ ├── selfie/Selfie.t.sol │ └── compromised/Compromised.t.sol └── README.md


Each test ensures the exploit **successfully breaks the protocol**.

---

## 📖 Solutions  

The **detailed solutions** and **proof-of-concepts (PoCs)** for these challenges are available in the GitHub repository.  

🔗 **Check out the solutions and PoCs**:  
👉 [https://github.com/SkyWarrior123/dvd-solutions/](https://github.com/SkyWarrior123/dvd-solutions/)  

---

## 🚀 Getting Started  

### 🔧 Installation  

1️⃣ **Clone the repository**  
```bash
git clone https://github.com/SkyWarrior123/dvd-solutions.git
cd dvd-solutions
```
2️⃣ Set up the environment
```
cp .env.sample .env
# Add a valid RPC URL for mainnet forking challenges
```
3️⃣ Install Foundry
```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```
4️⃣ Build the project
```
forge build
```
📌 Navigation in GitHub

Each challenge is structured with:
```
    A README.md inside src/<challenge-name>/ explaining the vulnerability.
    A smart contract inside src/<challenge-name>/ with the exploit target.
    A Foundry test inside test/<challenge-name>/ to validate the exploit.
```
To solve a challenge:

1️⃣ Read the challenge description in the src/<challenge-name>/README.md file.
2️⃣ Analyze the flaw in the smart contract located inside src/<challenge-name>/.
3️⃣ Write an exploit in the corresponding test file.
4️⃣ Run tests to confirm the exploit worked:
```
forge test --mp test/<challenge-name>/<ChallengeName>.t.sol
```
5️⃣ Use --isolate if transaction limits apply.

If the test passes, the challenge is solved! ✅

ONLY FOR EDUCATIONAL PURPOSES

📌 For more details, visit:
👉 https://github.com/SkyWarrior123/dvd-solutions/

Stay secure! 🚀
