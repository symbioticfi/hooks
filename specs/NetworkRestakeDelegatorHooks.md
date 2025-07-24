## Hooks

### NetworkRestakeDecreaseHook

NetworkRestakeDecreaseHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook decreases the network’s limit by the slashed amount and decreases the slashed operator’s shares (in case of network limit less than or equal to the active deposits, the stake will be decreased by the slashed amount, not changing other operators' stakes, otherwise, the stake changes depend on the active deposits).

### NetworkRestakeRedistributeHook

NetworkRestakeRedistributeHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook decreases the slashed operator's shares by slashed percent from the given stake, redistributing the decreased stake to other operators.

### NetworkRestakeResetHook

NetworkRestakeResetHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook resets the slashed operator's shares to zero in case it was slashed a configured number of times during a configured period of time.
