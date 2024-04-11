// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotesQuorumFraction.sol";

/**
 * @title Basic DAO
 * @author Breakthrough Labs Inc.
 * @notice DAO, Governance
 * @custom:version 0.0.2r
 * @custom:address 21
 * @custom:default-precision 0
 * @custom:simple-description A standard DAO setup. Voting period of 1 week, with a 1 block voting delay.
 * @dev A very simple implementation of a DAO. Voting period is locked in at 1 week,
 * and the voting delay is 1 block. There is no delay on approved proposals.
 */
contract SimpleDAO is Governor, GovernorCountingSimple, GovernorVotes, GovernorVotesQuorumFraction {
    string private _contractName;

    constructor(
        string memory contractName,
        IVotes _token,
        uint256 _quorumThreshold
    )
        Governor("SimpleDAO")
        GovernorVotes(_token)
        GovernorVotesQuorumFraction(_quorumThreshold)
    {
        _contractName = contractName;
    }

    function setName(string memory newName) external {
        _contractName = newName;
    }

    function getName() external view returns (string memory) {
        return _contractName;
    }

    function votingDelay() public pure override returns (uint256) {
        return 1; // 1 block
    }

    function votingPeriod() public pure override returns (uint256) {
        return 45818; // 1 week
    }

    function quorum(uint256 blockNumber) public view override(IGovernor, GovernorVotesQuorumFraction) returns (uint256) {
        return super.quorum(blockNumber);
    }
}