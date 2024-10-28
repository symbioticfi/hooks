## Hooks

### FullRestakeDecreaseHook

FullRestakeDecreaseHook supports `onSlash()` calls only from `FullRestakeDelegator`.

This hook decreases the network's limit by the slashed amount and decreases the operator's limit also by the slashed amount. It doesn't change stake amounts for other operators.

### FullRestakeResetHook

FullRestakeResetHook supports `onSlash()` calls only from `FullRestakeDelegator`.

This hook resets the slashed operator's limit to zero in case it was slashed a configured number of times during a configured period of time.
