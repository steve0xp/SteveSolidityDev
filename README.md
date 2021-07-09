# erc721MiddlePerson
A side project to create a contract(s) that allow for trust-worthy transference of ERC721s between two addresses.


# Design Concept
- Intent is to discuss, asynchronously, the design concept for this project.
- Core function: offer a middleman contract that allows two users to submit one ERC721 for another. Acts as an escrow in a sense, where the submitted NFT from one user will 
be kept in the contract until the other user deposits their token. An if statement will require that both tokens are submitted to the contract, that will then send the 
respective traded NFTs to the respective users. 
- Both users submit each others addresses, and the respective NFTs to be traded for their specific NFT. 
- Contract checks if the contract contains the NFTs inquired. This can be done a couple ways I think... mapping with the address of the user who deposited and the NFT put up for grabs.
- Basically have a conditional statement requiring that the other half of the trade is actually accounted for by the contract. Essentially once the conditions are met, the contract will just record who which respective NFT will go to now that the trade is complete. There is no backing out at this point (for now in this contract version). Similar to ETHPool, where the users are responsible for pulling their rewards (in this case the traded NFT) from the contract. The mapping or whatever is used to track the NFT traded will be reset accordingly.
- Much more can be done, to be thought out tomorrow morning.
### Reading Material
- [EIP-721: ERC-721 Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721)

### Tasks to complete
- [/] review EIP-721 - SP: Read over it, but need to create one and work with it similar to ERC20 to fully get it I believe.
- [/] create ERC-721 - SP: looked for video tutorials to kickstart things. Found one with some medium articles by a dev or someone at ChainLink actually. Working on creating one tomorrow, the content I've found so far actually covers more of the testing and app-side dev-work but the solidity itself doesn't look complicated so far. 
- [/] outline conceptual design to review with DK before writing interface: conceptual design written out in notion and shared, but will be updated much more tomorrrow morning.
    - this will help catch any unecessary scope challenges.
- [ ] outline interface and pseudo-code
    - [ ] review with DK
- [ ] write implementation code
    - [ ] review with DK
- [ ] write testing plan
- [ ] compile and test
- [ ] review with DK and finalize

