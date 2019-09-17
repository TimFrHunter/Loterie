pragma solidity 0.5.11;

/**
 *  Loterie By Tim S.
 *  Le tirage au sort du gagnant de la loterie est fait en dehors du contrat
 *  Actions possibles pour les participants: depot()
 *  Actions specifiques à l'Admin du contrat:
 *      - retrait()         // envoie des ethers au gagnant
 *      - setLoterieEtat()  // ouverture & fermeture de la Loterie
 *
 */

contract Loterie {

  address owner; // Admin contrat Loterie
  address payable[] clients; // participants
  bool public loterieEtat; // loterie ouverte ou fermée

  constructor() public {
      owner = msg.sender;
      loterieEtat = false;
  }

   modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  modifier loterieEnCours {
      require(loterieEtat == true);
      _;
  }



  //Echange Contrat & Clients

  function depot() external payable loterieEnCours {
    require(msg.value == 1 wei);
    clients.push(msg.sender);
  }

  function retrait(uint256 idx) public onlyOwner {
      clients[idx].transfer(address(this).balance);
  }


  // Infos Contrat

  function balance() public view returns (uint256) {
      return address(this).balance;
  }

  // Ouverture & Fermeture de la Loterie

  function setLoterieEtat(bool etat) public onlyOwner {
      loterieEtat = etat;
  }








}
