//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Voting{
    address electionCommissioner;
    uint pass=140;
    constructor(){
    electionCommissioner=msg.sender;
   
    }

    struct Candidate{
        address candidate_name;
        string representative_name;
        string party_Name;
        string party_Symbol;
        uint candidate_Id;
        uint candidate_age;
        string candidate_nationality;
        string current_position_in_party;
        string gender;
        uint votes_polled;
    }
      
    struct voter{
        string authorise;
        uint voterId;
        uint voter_age;
        string voter_gender;
        address voter_name;
        string voter_nationality;
        uint max_no_of_votes;
        uint passwo;
    }
    struct Constituency{
        address Candidate_for_Constituency;
        string party_symboll;
        string contituency_name;
        string district_name;
        string state;
    }
    modifier onlyElectionCommissioner(){
        require(msg.sender==electionCommissioner);
        _;
    }

    mapping(string=>Candidate)public candy;
    Candidate[] no_of_candidates;
    voter[] no_of_voters;
    Constituency[] no_of_Constituency;
    mapping(string=>Constituency)public Constituenc;
    mapping(address=>voter)public vot;
    uint Total_no_of_votes=0;
    function editPassword(address un1,uint pa,uint npa)public  returns(uint){
          for(uint i=0;i<no_of_voters.length;i++){
                  if(un1 == no_of_voters[i].voter_name){
             if(keccak256(abi.encodePacked((no_of_voters[i].passwo))) == keccak256(abi.encodePacked((pa)))){
                       //  no_of_voters[i].passwo=npa;
                       vot[un1].passwo=0;
                         vot[un1].passwo = npa;
                    return 1;
            }
                  }
              }
              return 0;
    }
      function login(address unq,uint password)public view returns(uint) {
        if(unq == electionCommissioner){
            if(pass == password){
                  return 1;
          }
      }
              for(uint i=0;i<no_of_voters.length;i++){
                  if(unq == no_of_voters[i].voter_name){
             if(keccak256(abi.encodePacked((no_of_voters[i].voterId))) == keccak256(abi.encodePacked((password)))){
                    return 2;
            }
                  }
              }
          return 0;
      }

      function validateCandidate(address _name,string memory _partyName,string memory _partySymbol,
        uint _Id)internal view returns(bool){
            for(uint i=0;i<no_of_candidates.length;i++){
                  require(keccak256(abi.encodePacked((no_of_candidates[i].candidate_name))) != keccak256(abi.encodePacked((_name))));
             require(keccak256(abi.encodePacked((no_of_candidates[i].party_Symbol))) != keccak256(abi.encodePacked((_partySymbol))));
              require(keccak256(abi.encodePacked((no_of_candidates[i].party_Name))) != keccak256(abi.encodePacked((_partyName))));
               require(keccak256(abi.encodePacked((no_of_candidates[i].candidate_Id))) != keccak256(abi.encodePacked((_Id))));
            }
            return true;
        }
      function validateVoter(uint _id,address _name)internal view returns(bool){
              for(uint i=0;i<no_of_voters.length;i++){
                  require(keccak256(abi.encodePacked((no_of_voters[i].voterId))) != keccak256(abi.encodePacked((_id))));
             require(keccak256(abi.encodePacked((no_of_voters[i].voter_name))) != keccak256(abi.encodePacked((_name))));
            }
          return true;
       }
      function validateConstituency(address candi,string memory symbio) internal view returns(bool){
            for(uint i=0;i<no_of_Constituency.length;i++){
                  require(keccak256(abi.encodePacked((no_of_Constituency[i].Candidate_for_Constituency))) != keccak256(abi.encodePacked((candi))));
             require(keccak256(abi.encodePacked((no_of_Constituency[i].party_symboll))) != keccak256(abi.encodePacked((symbio))));
            }
            return true;
      }
    function setCandidate(address _name,string memory _cname,string memory _partyName,string memory _partySymbol,
        uint _Id,uint _age,string memory _nationality,string memory _partyposition,string memory _gen,uint _votes)
        public onlyElectionCommissioner returns(string memory){
        require(validateCandidate(_name,_partyName,_partySymbol,_Id));
            string memory message;
            require(_age>=25);
            if(_age>=25){
                require(_votes==0);
                if(_votes==0){
        candy[_partySymbol]=Candidate(_name,_cname,_partyName,_partySymbol,_Id,_age,_nationality,_partyposition,_gen,_votes);
        no_of_candidates.push(Candidate(_name,_cname,_partyName,_partySymbol,_Id,_age,_nationality,_partyposition,_gen,_votes));
        message="Candidate Successfully added.";
                }
                else{
                    message="A Candidate's vote poll count should be initialized to zero.Please Review";
                }
    }
    else{
        message="Candidate Not Added !!! .Candidate's age should be greater than or equal to 25 years.";
    } 
    return (message);
        }
   
    function setVoter(string memory _autho,uint _id,uint _age,string memory _gender,address _name,
       string memory _nationality,uint max_votes,uint pa)public onlyElectionCommissioner returns (string memory){
           require(validateVoter(_id,_name));
           string memory message;
           require(_age>=18);
           if(_age>=18){
               require(max_votes==1);
               if(max_votes==1){
       vot[_name]=voter(_autho,_id,_age,_gender,_name,_nationality,max_votes,pa);
       no_of_voters.push(voter(_autho,_id,_age,_gender,_name,_nationality,max_votes,pa));
       message="Voter Successfully added.";
               }
               else{
                  message="A voter should be allotted 1 vote not more than that.Please review "; 
               }
           }
           else{
               message="Voter Not Added.!!! Voter's age must be greater than or equal to 18 years. ";
           }
return (message);
    }
    function getVoter()public view returns (address[] memory,uint[] memory){
        address[] memory name=new address[](no_of_voters.length);
        uint[] memory votes=new uint[](no_of_voters.length); 
        for(uint i=0;i<no_of_voters.length;i++){
                name[i]=no_of_voters[i].voter_name;
                address  temp=no_of_voters[i].voter_name;
                votes[i]=vot[temp].max_no_of_votes;
        }
        return (name,votes);
    }
   function setConstituency(address _Candidate_Consti,string memory p_symbol,string memory c_name,
   string memory d_name,string memory s_name)public onlyElectionCommissioner{
       require(validateConstituency(_Candidate_Consti ,p_symbol));
       Constituenc[p_symbol]=Constituency(_Candidate_Consti,p_symbol,c_name,d_name,s_name);
      no_of_Constituency.push(Constituency(_Candidate_Consti,p_symbol,c_name,d_name,s_name));
   }
    function CandidateLength()public view returns(uint){
       return no_of_candidates.length;
    }
     
    function vote(address voter_address,string memory vote_for,uint  passwordd)public  returns(string memory){
        string memory message;
        require(keccak256(abi.encodePacked((vot[voter_address].authorise))) == keccak256(abi.encodePacked(("true"))));
    if(keccak256(abi.encodePacked((vot[voter_address].authorise))) == keccak256(abi.encodePacked(("true")))){
        require(vot[voter_address].voter_age>=18);
        if(vot[voter_address].voter_age>=18){
            require(vot[voter_address].max_no_of_votes==1);
        if(vot[voter_address].max_no_of_votes==1){
            require(keccak256(abi.encodePacked((candy[vote_for].party_Symbol))) == keccak256(abi.encodePacked((vote_for))));
            require(vot[voter_address].passwo != vot[voter_address].voterId);
            require(keccak256(abi.encodePacked((vot[voter_address].passwo))) == keccak256(abi.encodePacked((passwordd))));
           if (keccak256(abi.encodePacked((candy[vote_for].party_Symbol))) == keccak256(abi.encodePacked((vote_for)))){
             candy[vote_for].votes_polled+=1;
            
             vot[voter_address].max_no_of_votes=0;
             vot[voter_address].authorise="false";
             message="Your Vote has been successfully casted.Thank you for voting.Have a good day.";
           }
           else{
               message="Invalid party symbol.please re-check the symbol and cast the vote.";
           } 
        }
        else{
            message="You have been allotted more than one vote.Hence cannot be permitted to vote.Please reach out to concerned authorities for problem resolution.Thank you.";
        }
    }
    else{
        message="Your age is below 18 years,you are not eligible to vote.Thank you";
    }
      }
      else{
          message="You are not authorized to vote.please reach out to concerned authorities for resolution of problem.Thank you";
      }  
      return (message);
   }
   function Result()public view returns(string memory party_name,string memory party_symbol,string memory represent_name,string memory constituency,
   string memory district,string memory state,uint _winnervotes,string memory){
       string memory message="Congratulations on your win!!!!";
      uint  winnervotes=0;
      string memory key;
       for(uint i=0;i<no_of_candidates.length;i++){
           string memory nn= no_of_candidates[i].party_Symbol;
               if(candy[nn].votes_polled > winnervotes){
                 winnervotes = candy[nn].votes_polled;
                key=nn;
               }
              else if(candy[nn].votes_polled == winnervotes)
                   return("Election Tied","!!!","","","","",winnervotes,"Election Tied");
       }
       return (candy[key].party_Name,candy[key].party_Symbol,candy[key].representative_name,Constituenc[key].contituency_name,
       Constituenc[key].district_name
       ,Constituenc[key].state,winnervotes,message);
   }
   function AllCandidates()external view returns(string memory,string[] memory party_name,string[] memory party_symbol,
   string[] memory candidate_name,string[] memory _Constituency_Name,uint[] memory){
       string memory message="These are all the candidates and their party symbols.Kindly pick your party symbol and vote for it.Thank you.";
       string[] memory List =new string[](no_of_candidates.length) ;
      string[] memory symbols=new string[](no_of_candidates.length);
      string[] memory Clist=new string[](no_of_candidates.length);
      string[] memory ConList=new string[](no_of_candidates.length);
      uint[] memory votess=new uint[](no_of_candidates.length);
      for(uint i=0;i<no_of_candidates.length;i++){
          List[i]=no_of_candidates[i].party_Name;
          symbols[i]=no_of_candidates[i].party_Symbol;
          Clist[i]=no_of_candidates[i].representative_name;
          string memory temp=no_of_candidates[i].party_Symbol;
          ConList[i]=Constituenc[temp].contituency_name;
          votess[i]=candy[temp].votes_polled;
      }
      return (message,List,symbols,Clist,ConList,votess);
       }
}

