//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IFullRestakeDecreaseHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iFullRestakeDecreaseHookAbi = [
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "NotFullRestakeDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IFullRestakeResetHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iFullRestakeResetHookAbi = [
  {
    type: "function",
    inputs: [],
    name: "PERIOD",
    outputs: [{ name: "", internalType: "uint48", type: "uint48" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [],
    name: "SLASH_COUNT",
    outputs: [{ name: "", internalType: "uint256", type: "uint256" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "InvalidSlashCount" },
  { type: "error", inputs: [], name: "NotFullRestakeDelegator" },
  { type: "error", inputs: [], name: "NotVaultDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INetworkRestakeDecreaseHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iNetworkRestakeDecreaseHookAbi = [
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "NotNetworkRestakeDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INetworkRestakeRedistributeHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iNetworkRestakeRedistributeHookAbi = [
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "NotNetworkRestakeDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INetworkRestakeResetHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iNetworkRestakeResetHookAbi = [
  {
    type: "function",
    inputs: [],
    name: "PERIOD",
    outputs: [{ name: "", internalType: "uint48", type: "uint48" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [],
    name: "SLASH_COUNT",
    outputs: [{ name: "", internalType: "uint256", type: "uint256" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "InvalidSlashCount" },
  { type: "error", inputs: [], name: "NotNetworkRestakeDelegator" },
  { type: "error", inputs: [], name: "NotVaultDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IOperatorSpecificDecreaseHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iOperatorSpecificDecreaseHookAbi = [
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "NotOperatorSpecificDelegator" },
] as const

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IOperatorSpecificResetHook
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export const iOperatorSpecificResetHookAbi = [
  {
    type: "function",
    inputs: [],
    name: "PERIOD",
    outputs: [{ name: "", internalType: "uint48", type: "uint48" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [],
    name: "SLASH_COUNT",
    outputs: [{ name: "", internalType: "uint256", type: "uint256" }],
    stateMutability: "view",
  },
  {
    type: "function",
    inputs: [
      { name: "subnetwork", internalType: "bytes32", type: "bytes32" },
      { name: "operator", internalType: "address", type: "address" },
      { name: "amount", internalType: "uint256", type: "uint256" },
      { name: "captureTimestamp", internalType: "uint48", type: "uint48" },
      { name: "data", internalType: "bytes", type: "bytes" },
    ],
    name: "onSlash",
    outputs: [],
    stateMutability: "nonpayable",
  },
  { type: "error", inputs: [], name: "InvalidSlashCount" },
  { type: "error", inputs: [], name: "NotOperatorSpecificDelegator" },
  { type: "error", inputs: [], name: "NotVaultDelegator" },
] as const
