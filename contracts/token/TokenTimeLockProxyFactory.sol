// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./TokenTimeLock.sol";

contract TokenTimeLockProxyFactory{
    event ProxyCreated(
        address proxy,
        address implementation,
        address proxyOwner
    );

    function createProxy(
        address owner_,
        address lock,
        address user_,
        address token_,
        uint256 amount_,
        uint32[] calldata lockDurations_,
        uint32[] calldata releasePercents_,
        uint64 startDate_
    ) public returns (address) {
        address proxy = Clones.clone(lock);
        bool setupResult = TokenTimeLock(proxy).initialize(
            owner_,
            user_,
            token_,
            amount_,
            lockDurations_,
            releasePercents_,
            startDate_
        );
        require(setupResult, "TokenTimeLockProxy: can't setup");

        emit ProxyCreated(proxy, lock, owner_);

        return proxy;
    }
}
