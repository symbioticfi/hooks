// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package rewardsv2contracts

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
	_ = abi.ConvertType
)

// INetworkRestakeRedistributeHookMetaData contains all meta data concerning the INetworkRestakeRedistributeHook contract.
var INetworkRestakeRedistributeHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"NotNetworkRestakeDelegator\",\"inputs\":[]}]",
}

// INetworkRestakeRedistributeHookABI is the input ABI used to generate the binding from.
// Deprecated: Use INetworkRestakeRedistributeHookMetaData.ABI instead.
var INetworkRestakeRedistributeHookABI = INetworkRestakeRedistributeHookMetaData.ABI

// INetworkRestakeRedistributeHook is an auto generated Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHook struct {
	INetworkRestakeRedistributeHookCaller     // Read-only binding to the contract
	INetworkRestakeRedistributeHookTransactor // Write-only binding to the contract
	INetworkRestakeRedistributeHookFilterer   // Log filterer for contract events
}

// INetworkRestakeRedistributeHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeRedistributeHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeRedistributeHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type INetworkRestakeRedistributeHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeRedistributeHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type INetworkRestakeRedistributeHookSession struct {
	Contract     *INetworkRestakeRedistributeHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts                    // Call options to use throughout this session
	TransactOpts bind.TransactOpts                // Transaction auth options to use throughout this session
}

// INetworkRestakeRedistributeHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type INetworkRestakeRedistributeHookCallerSession struct {
	Contract *INetworkRestakeRedistributeHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                          // Call options to use throughout this session
}

// INetworkRestakeRedistributeHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type INetworkRestakeRedistributeHookTransactorSession struct {
	Contract     *INetworkRestakeRedistributeHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                          // Transaction auth options to use throughout this session
}

// INetworkRestakeRedistributeHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHookRaw struct {
	Contract *INetworkRestakeRedistributeHook // Generic contract binding to access the raw methods on
}

// INetworkRestakeRedistributeHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHookCallerRaw struct {
	Contract *INetworkRestakeRedistributeHookCaller // Generic read-only contract binding to access the raw methods on
}

// INetworkRestakeRedistributeHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type INetworkRestakeRedistributeHookTransactorRaw struct {
	Contract *INetworkRestakeRedistributeHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewINetworkRestakeRedistributeHook creates a new instance of INetworkRestakeRedistributeHook, bound to a specific deployed contract.
func NewINetworkRestakeRedistributeHook(address common.Address, backend bind.ContractBackend) (*INetworkRestakeRedistributeHook, error) {
	contract, err := bindINetworkRestakeRedistributeHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeRedistributeHook{INetworkRestakeRedistributeHookCaller: INetworkRestakeRedistributeHookCaller{contract: contract}, INetworkRestakeRedistributeHookTransactor: INetworkRestakeRedistributeHookTransactor{contract: contract}, INetworkRestakeRedistributeHookFilterer: INetworkRestakeRedistributeHookFilterer{contract: contract}}, nil
}

// NewINetworkRestakeRedistributeHookCaller creates a new read-only instance of INetworkRestakeRedistributeHook, bound to a specific deployed contract.
func NewINetworkRestakeRedistributeHookCaller(address common.Address, caller bind.ContractCaller) (*INetworkRestakeRedistributeHookCaller, error) {
	contract, err := bindINetworkRestakeRedistributeHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeRedistributeHookCaller{contract: contract}, nil
}

// NewINetworkRestakeRedistributeHookTransactor creates a new write-only instance of INetworkRestakeRedistributeHook, bound to a specific deployed contract.
func NewINetworkRestakeRedistributeHookTransactor(address common.Address, transactor bind.ContractTransactor) (*INetworkRestakeRedistributeHookTransactor, error) {
	contract, err := bindINetworkRestakeRedistributeHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeRedistributeHookTransactor{contract: contract}, nil
}

// NewINetworkRestakeRedistributeHookFilterer creates a new log filterer instance of INetworkRestakeRedistributeHook, bound to a specific deployed contract.
func NewINetworkRestakeRedistributeHookFilterer(address common.Address, filterer bind.ContractFilterer) (*INetworkRestakeRedistributeHookFilterer, error) {
	contract, err := bindINetworkRestakeRedistributeHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeRedistributeHookFilterer{contract: contract}, nil
}

// bindINetworkRestakeRedistributeHook binds a generic wrapper to an already deployed contract.
func bindINetworkRestakeRedistributeHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := INetworkRestakeRedistributeHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeRedistributeHook.Contract.INetworkRestakeRedistributeHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.INetworkRestakeRedistributeHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.INetworkRestakeRedistributeHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeRedistributeHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.contract.Transact(opts, method, params...)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.OnSlash(&_INetworkRestakeRedistributeHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeRedistributeHook *INetworkRestakeRedistributeHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeRedistributeHook.Contract.OnSlash(&_INetworkRestakeRedistributeHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
