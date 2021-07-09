// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

// Inheritance... need to populate, this is just pseudo-code phase atm. 

import "./Ierc721MiddleMan.sol";

    /**
     * @title erc721MiddleMan
     * @author Steven Pham
     * @notice Summary: The ETHDeposit contract allows ETH to be deposited by a user. Each user that deposits ETH into the contract will get
     * ERC20 rewards token, CURL, at the end of each reward period. Users can claim their token after each reward period. Users can withdraw their ETH and CURL whenever they like. 
     * @dev The governor is responsible for calling functions 1.) depositRewards; depositing CURL tokens into this contract, and 
     * 2.) distributeRewards. distributeRewards requires that the Governor manually inputs the separate arrays of depositor's addresses externally derived off-chain. 
     */

contract erc721MiddleMan is Ierc721MiddleMan {

    
     //STATE VARIABLES:
    //  mapping (address => uint256) public pendingNFTToBeTraded;
    //  mapping (address => pendingNFTToBeTraded) public proposedTrade; //hmm might not go with this
     struct ProposedTrade {
         IERC721 nft1;
         IERC721 nft2;
         address user1;
         address user2;
         bool tradeInitiated;
     } 
     /**
     * where a proposed trade is created in the proposedTrade function. User1 actually transfers their NFT temporarily to this contract. 
     * Then the bool is set to TRUE, representing the initiated trade. 
     

     
     
    
   /* ========== EVENTS ========== */

      /**
     * @notice display initiated trade details
     */
    event proposedTrade(string tradeName, uint256 user1TokenId, address user2, uint256 user2TokenID);
     
    /**
     * @notice display name of completed trade. Users should check their wallets to see that they have received the NFTs.
     */
    event completedTrade(string tradeName);

   /* ========== VIEWS ========== */

   /* ========== MODIFIERS ========== */

   /* ========== CONSTRUCTOR ========== */

   /* ========== MUTATIVE FUNCTIONS ========== */

    /**
     * @notice trade initiator will propose a trade with a specific user in mind, for specific NFTs. 
     * @dev function returns a boolean. This boolean is associated to a mapping that is created when the trade is initiated. 
     * Approval for this contract to transfer the respective initiator's NFT is allowed as well, but the actual transfer is carried out
     * in another function that requires that both users have deposited their NFTs to be traded (and their respective mappings are populated and return true bools).
     * note: not sure if the inputs need to specify certain ERC721 contract origins. ex.) similar to ERC20's where the token name is referenced as that is the specific ERC20 one is interacting with.
     * "_" means local variable, otherwise it is a state variable.
     */
    function proposeTrade(string tradeName, uint256 user1TokenId, address user2, uint256 user2TokenID) public override view returns(struct) {
        ProposedTrade public tradeName;
        tradeName.nft1 = user1TokenID; //I realize that this is an IERC721, not the uint256 tokenId... for now you get the gist of what I'm trying to do I hope though.
        tradeName.user1 = msg.sender;
        tradeName.nft2 = user2TokenID;
        tradeName.user2 = user2;
        tradeName.tradeInitiated = true;
        return tradeName; //I'm hoping this makes the instantiated local struct now stored in storage such that it can be used by other functions. If not, then this all needs to be rethunk.
        tradeName.nft1.safeTransferFrom(user1, address(this), user1TokenId);
        emit proposedTrade(string tradeName, uint256 user1TokenId, address user2, uint256 user2TokenID); 

    }

    /**
     * The next function in the sequence can be
     * used; function user2Approve(). This function would have the second user of the trade provide approval for their NFT to be transfered to MiddleMan, and actually transfer
     * the NFT to middleMan.  This function would set another bool: "user2TradeApproved." I think this would be in the struct. 
     */
    function user2Approve(string tradeName) public override {
        
        if(tradeName.tradeInitiated) {
            require(tradeName.user2 = msg.sender, "You are not the approved party for this trade");
            tradeName.nft2.safeTransferFrom(msg.sender, address(this), tradeName.nft2);
        }

    }

    function cancel(string tradeName) public override {
        require (tradeName.tradeInitiated, "This trade does not exist");
        tradeName.tradeInitiated = false;
        //is there a way to delete structs. Could look into this
        if ((tradeName.nft1._owners(tradeName.nft1)) = address(this)) { 
            tradeName.nft1.safeTransferFrom(address(this), tradeName.user1, user1TokenId);
        } else {
            if ((tradeName.nft2._owners(tradeName.nft2)) = address(this)) { 
                tradeName.nft2.safeTransferFrom(address(this), tradeName.user2, user2TokenId);
        }
    }

    /** From there the third function of the trade sequence is hit.
     * 3rd function tradezies(); //where middleMan sends the two NFTs within its possession to the respective users. Checks to make sure neither have cancelled the trade, and 
     * then sends them out using safeTransfer. **** I'm hesistant to do transferFrom from one user to the next because could they not cancel the approved trade after they took the other 
     * person's NFT? So it would be good to send to the contract the NFTs so they could not just demand it back unless they cancel the trade, but the contract would have logic
     * in it that doesn't allow cancels to happen if the other NFT has been traded.
     */
    function tradezies(string tradeName) public override {
        require (!((tradeName.nft1._owners(tradeName.nft2)) = (tradeName.user1 || tradeName.user1)), "Someone has cancelled on the trade, trade is void") 
        //proceed with trade where contract sends nfts to respective users.
        tradeName.nft1.safeTransferFrom(address(this), tradeName.user2, user1TokenId);
        tradeName.nft2.safeTransferFrom(address(this), tradeName.user1, user2TokenId);
        emit completedTrade(string tradeName);
    }

}

// old code I may use in last function:     if ((tradeName.nft1._owners(tradeName.nft2)) = address(this) && (tradeName.nft1._owners(tradeName.nft1)) = address(this))