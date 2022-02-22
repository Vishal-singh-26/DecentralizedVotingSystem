// Import Web3 JS library
const Web3 = require('web3');

// Import the ABI definition of the DemoContract
const artifact = require('../../build/contracts/Voting.json');

const contractAddress = '0x5942A0bA94ca6982e1EFdF61f839c0B4C7420de7';


const App = {
    web3: null,
    contractInstance: null,
    accounts: null,

    start: async function() {
        const { web3 } = this;
        // Get the accounts
        this.accounts = await web3.eth.getAccounts();
       
        console.log(this.accounts);

        this.contractInstance = new web3.eth.Contract(
            artifact.abi,
            contractAddress
        ); 
    },
    setCandidate: async function(){
    const add=document.getElementById('uniqueaddress').value;
        const name=document.getElementById('r_name').value;
        const pn=document.getElementById('p_name').value;
        const ps=document.getElementById('p_symbol').value;
        const ci=document.getElementById('cid').value;
        const ca=document.getElementById('c_age').value;
        const cnn=document.getElementById('nation').value;
        const po=document.getElementById('pos').value;
        const gen=document.getElementById('gender').value;
        const vp=document.getElementById('votes_polled').value;
await this.contractInstance.methods.setCandidate(add,name,pn,ps,ci,ca,cnn,po,gen,vp).send({
    from:this.accounts[0],
    gas:1000000
})
alert("Candidate has been successfully registered");
    },
    setConstituency: async function(){
        var ps=document.getElementById('ConUnq').value;
        var ci=document.getElementById('CP_Symbol').value;
        var ca=document.getElementById('CP_name').value;
        var cnn=document.getElementById('D_name').value;
        var po=document.getElementById('S_name').value;
        await this.contractInstance.methods.setConstituency(ps,ci,ca,cnn,po).send({
            from:this.accounts[0],
            gas:1000000
        })
        alert("Candidate Constituency has been successfully set");
    },
    setVoter: async function(){
        var ps=document.getElementById('bool').value;
        var ci=document.getElementById('V_id').value;
        var ca=document.getElementById('v_age').value;
        var cnn=document.getElementById('v_gender').value;
        var po=document.getElementById('vadd').value;
        var gen=document.getElementById('v_nat').value;
        var vp=document.getElementById('v_all').value;
        var vpas=document.getElementById('v_passwo').value;
        await this.contractInstance.methods.setVoter(ps,ci,ca,cnn,po,gen,vp,vpas).send({
            from:this.accounts[0],
            gas:1000000
        })
        alert("Voter has been successfully Registered");
    },
    getvoterss: async function(){
        var res=await this.contractInstance.methods.getVoter().call();
       var {0: res1,1:res2}=res;
        alert("Unique Address of Voters      "+res1+"\n"+"Max_no_of_votes       "+res2);
    },
    editpassword: async function(){
        var ad=document.getElementById('uvadd').value;
        var op=document.getElementById('opa').value;
        var np=document.getElementById('npaa').value;
        await this.contractInstance.methods.editPassword(ad,op,np).send({
            from:ad,
            gas:1000000
        })
        alert("Password has been changed Successfully");
    },
    login: async function(){
        var ad=document.getElementById('address').value;
        var pa=document.getElementById('password').value;
       var ann=await this.contractInstance.methods.login(ad,pa).call();
        if(ann==0){
            alert("User Not Registered!!!");
        }
        if(ann==1){
            window.location.href='/index1.html';
            alert("Welcome Election Commissioner");
        }
        if(ann==2){
            window.location.href='/index4.html';
            alert("Welcome Voter ");
        }
    },

    getCandidateDetails: async function(){
        var data=await this.contractInstance.methods.AllCandidates().call();
        var {0:message,1:str1,2:str2,3:str3,4:str4,5:str5}=data;
      alert(message);
      alert("Party        "+str1+"\n" +"Symbol        "+str2+"\n"+"Name         "+str3+"\n"+"Constituency "+str4+"\n"+"Votes_Polled "+str5);
    },
    votefor: async function(){
        var addresss=document.getElementById('uvadd').value;
        var choice=document.getElementById('vote').value;
        var paaa=document.getElementById('as').value;
      await this.contractInstance.methods.vote(addresss,choice,paaa).send({
          from:addresss,
          gas:1000000
      }),
      alert("Your Vote has been Successfully Cast. Thank you for Voting. Have a Nice Day.");
    },
    reesult: async function(){
        var winner=await this.contractInstance.methods.Result().call();
        var {0: party_name,1:party_symbol,2: Represent_name,3:contituency_name,4:district_name,5:state_name,6:votes_polled,7:message}=winner;
        alert( "Party        "+party_name+"\n"+"Symbol       "+party_symbol+"\n"+"Name         "+Represent_name+"\n"+
        "Constituency "+contituency_name+"\n"+"District     "+district_name+"\n"+"State        "+state_name+"\n"+"Votes        "+votes_polled+"\n"+message);
        
    },

};

window.App = App;

window.addEventListener("load", function() {
    

    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:7545"),
    );

  App.start();
});
