// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

/**
 * @notice IGNORE THIS INTERFACE FOR NOW. PLEASE SEE erc721MiddleMan for conceptual design in comments and pseudo-code/code roughdraft.
 * @dev Interface of the erc721MiddleMan contract.
 */
interface Ierc721MiddleMan {
    
    /**
     * STATE VARIABLES:
     * mapping (address => uint256) public pendingNFTToBeTraded;
     * mapping (address => pendingNFTToBeTraded) public proposedTrade; hmm might not go with this
     * struct ProposedTrade {
         IERC721 nft1;
         IERC721 nft2;
         address user1;
         address user2;
         bool tradeInitiated;
     } --> where a proposed trade is created in the proposedTrade function. User1 actually transfers their NFT temporarily to this contract. 
     * Then the bool is set to TRUE, representing the initiated trade. The next function in the sequence can be
     * used; function user2Approve(). This function would have the second user of the trade provide approval for their NFT to be transfered to MiddleMan, and actually transfer
     * the NFT to middleMan.  This function would set another bool: "user2TradeApproved." I think this would be in the struct. From there the third function of the trade sequence is hit.
     * 3rd function tradezies(); //where middleMan sends the two NFTs within its possession to the respective users. Checks to make sure neither have cancelled the trade, and 
     * then sends them out using safeTransfer. **** I'm hesistant to do transferFrom from one user to the next because could they not cancel the approved trade after they took the other 
     * person's NFT? So it would be good to send to the contract the NFTs so they could not just demand it back unless they cancel the trade, but the contract would have logic
     * in it that doesn't allow cancels to happen if the other NFT has been traded.
     */
    
    /**
     * @notice trade initiator will propose a trade with a specific user in mind, for specific NFTs. 
     * @dev function returns a boolean. This boolean is associated to a mapping that is created when the trade is initiated. 
     * Approval for this contract to transfer the respective initiator's NFT is allowed as well, but the actual transfer is carried out
     * in another function that requires that both users have deposited their NFTs to be traded (and their respective mappings are populated and return true bools).
     * note: not sure if the inputs need to specify certain ERC721 contract origins. ex.) similar to ERC20's where the token name is referenced as that is the specific ERC20 one is interacting with.
     * "_" means local variable, otherwise it is a state variable.
     */
    function proposeTrade(string tradeName, uint256 user1TokenId, address user2, uint256 user2TokenID) external view returns (bool);
    /**
     * pseudoCode: ProposedTrade public tradeName;
     * tradeName.nft1 = user1TokenID;
     * tradeName.user1 = msg.sender;
     * tradeName.nft2 = user2TokenID;
     * tradeName.user2 = user2;
     * 
     * 
     */ 