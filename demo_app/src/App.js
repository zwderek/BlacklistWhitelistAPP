import React, { useState } from "react";
import { Token } from "./abi/abi";
import Web3 from "web3";
import './App.css';

const web3 = new Web3(Web3.givenProvider);
const contractAddress = "0xE422254A424fd7b25f8446891b722feB2E4544f6";
const tokenContract = new web3.eth.Contract(Token, contractAddress);

function App() {
  const [number, setUint] = useState(0);
  const [b_address, setB] = useState("");
  const [w_address, setW] = useState("");
  
  const purchase = async (t) => {
    t.preventDefault();
    const accounts = await window.ethereum.enable();
    const account = accounts[0];
    
    console.log("address: ", account);
    console.log("number: ", number);
    const post = await tokenContract.methods.deposit().send({
      from: account,
      value: number,
    });
  };

  const setBlack = async (t) => {
    t.preventDefault();
    const accounts = await window.ethereum.enable();
    const account = accounts[0];

    console.log("address: ", b_address);
    const post = await tokenContract.methods.setBlacklist(b_address).send({
      from: account,
    });
  };

  const setWhite = async (t) => {
    t.preventDefault();
    const accounts = await window.ethereum.enable();
    const account = accounts[0];

    console.log("address: ", w_address);
    const post = await tokenContract.methods.setWhitelist(w_address).send({
      from: account,
    });
  };
  

  return (
     <div className="main">
       <div className="card">
         <form className="form" onSubmit={purchase}>
           <label>
             Purchase Token (input wei amount)
             <input
               className="input"
               type="text"
               name="name"
               onChange={(t) => setUint(t.target.value)}
             />
           </label>
           <button className="button" type="submit" value="Confirm">
             Deposit
           </button>
         </form>

         <form className="form" onSubmit={setBlack}>
           <label>
             Set BlackList (input address)
             <input
               className="input"
               type="text"
               name="name"
               onChange={(t) => setB(t.target.value)}
             />
           </label>
           <button className="button" type="submit" value="Confirm">
             Confirm
           </button>
         </form>

         <form className="form" onSubmit={setWhite}>
           <label>
             Set WhiteList (input address)
             <input
               className="input"
               type="text"
               name="name"
               onChange={(w_address) => setW(w_address.target.value)}
             />
           </label>
           <button className="button" type="submit" value="Confirm">
             Confirm
           </button>
         </form>

       </div>
     </div>
  );
}

export default App;