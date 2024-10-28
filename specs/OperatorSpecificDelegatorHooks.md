## Hooks

### OperatorSpecificDecreaseHook

OperatorSpecificDecreaseHook supports `onSlash()` calls only from `OperatorSpecificDelegator`.

This hook decreases the network's limit by the slashed amount.

### OperatorSpecificResetHook

OperatorSpecificResetHook supports `onSlash()` calls only from `OperatorSpecificDelegator`.

This hook resets the slashing network's limit to zero in case it was slashed a configured number of times during a configured period of time.
