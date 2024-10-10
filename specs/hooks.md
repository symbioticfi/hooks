## Hooks

### NetworkRestakeFairHook

NetworkRestakeFairHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook decreases the network limit by the slashed amount and decreases the slashed operator's shares in such a way to decrease his stake (which depends on the network limit) also by the slashed amount. It doesn't change stake amounts for other operators.

### NetworkRestakeRedistributionHook

NetworkRestakeRedistributionHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook decreases the slashed operator's shares by slashed percent from the given stake, redistributing the decreased stake to other operators.

### NetworkRestakeResetHook

NetworkRestakeResetHook supports `onSlash()` calls only from `NetworkRestakeDelegator`.

This hook resets the slashed operator's shares to zero in case it was slashed a configured number of times during a configured period of time.
