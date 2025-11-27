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

// IOperatorSpecificDecreaseHookMetaData contains all meta data concerning the IOperatorSpecificDecreaseHook contract.
var IOperatorSpecificDecreaseHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"NotOperatorSpecificDelegator\",\"inputs\":[]}]",
}

// IOperatorSpecificDecreaseHookABI is the input ABI used to generate the binding from.
// Deprecated: Use IOperatorSpecificDecreaseHookMetaData.ABI instead.
var IOperatorSpecificDecreaseHookABI = IOperatorSpecificDecreaseHookMetaData.ABI

// IOperatorSpecificDecreaseHook is an auto generated Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHook struct {
	IOperatorSpecificDecreaseHookCaller     // Read-only binding to the contract
	IOperatorSpecificDecreaseHookTransactor // Write-only binding to the contract
	IOperatorSpecificDecreaseHookFilterer   // Log filterer for contract events
}

// IOperatorSpecificDecreaseHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificDecreaseHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificDecreaseHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type IOperatorSpecificDecreaseHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificDecreaseHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type IOperatorSpecificDecreaseHookSession struct {
	Contract     *IOperatorSpecificDecreaseHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts                  // Call options to use throughout this session
	TransactOpts bind.TransactOpts              // Transaction auth options to use throughout this session
}

// IOperatorSpecificDecreaseHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type IOperatorSpecificDecreaseHookCallerSession struct {
	Contract *IOperatorSpecificDecreaseHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                        // Call options to use throughout this session
}

// IOperatorSpecificDecreaseHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type IOperatorSpecificDecreaseHookTransactorSession struct {
	Contract     *IOperatorSpecificDecreaseHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                        // Transaction auth options to use throughout this session
}

// IOperatorSpecificDecreaseHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHookRaw struct {
	Contract *IOperatorSpecificDecreaseHook // Generic contract binding to access the raw methods on
}

// IOperatorSpecificDecreaseHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHookCallerRaw struct {
	Contract *IOperatorSpecificDecreaseHookCaller // Generic read-only contract binding to access the raw methods on
}

// IOperatorSpecificDecreaseHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type IOperatorSpecificDecreaseHookTransactorRaw struct {
	Contract *IOperatorSpecificDecreaseHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewIOperatorSpecificDecreaseHook creates a new instance of IOperatorSpecificDecreaseHook, bound to a specific deployed contract.
func NewIOperatorSpecificDecreaseHook(address common.Address, backend bind.ContractBackend) (*IOperatorSpecificDecreaseHook, error) {
	contract, err := bindIOperatorSpecificDecreaseHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificDecreaseHook{IOperatorSpecificDecreaseHookCaller: IOperatorSpecificDecreaseHookCaller{contract: contract}, IOperatorSpecificDecreaseHookTransactor: IOperatorSpecificDecreaseHookTransactor{contract: contract}, IOperatorSpecificDecreaseHookFilterer: IOperatorSpecificDecreaseHookFilterer{contract: contract}}, nil
}

// NewIOperatorSpecificDecreaseHookCaller creates a new read-only instance of IOperatorSpecificDecreaseHook, bound to a specific deployed contract.
func NewIOperatorSpecificDecreaseHookCaller(address common.Address, caller bind.ContractCaller) (*IOperatorSpecificDecreaseHookCaller, error) {
	contract, err := bindIOperatorSpecificDecreaseHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificDecreaseHookCaller{contract: contract}, nil
}

// NewIOperatorSpecificDecreaseHookTransactor creates a new write-only instance of IOperatorSpecificDecreaseHook, bound to a specific deployed contract.
func NewIOperatorSpecificDecreaseHookTransactor(address common.Address, transactor bind.ContractTransactor) (*IOperatorSpecificDecreaseHookTransactor, error) {
	contract, err := bindIOperatorSpecificDecreaseHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificDecreaseHookTransactor{contract: contract}, nil
}

// NewIOperatorSpecificDecreaseHookFilterer creates a new log filterer instance of IOperatorSpecificDecreaseHook, bound to a specific deployed contract.
func NewIOperatorSpecificDecreaseHookFilterer(address common.Address, filterer bind.ContractFilterer) (*IOperatorSpecificDecreaseHookFilterer, error) {
	contract, err := bindIOperatorSpecificDecreaseHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificDecreaseHookFilterer{contract: contract}, nil
}

// bindIOperatorSpecificDecreaseHook binds a generic wrapper to an already deployed contract.
func bindIOperatorSpecificDecreaseHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := IOperatorSpecificDecreaseHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IOperatorSpecificDecreaseHook.Contract.IOperatorSpecificDecreaseHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.IOperatorSpecificDecreaseHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.IOperatorSpecificDecreaseHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IOperatorSpecificDecreaseHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.contract.Transact(opts, method, params...)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.OnSlash(&_IOperatorSpecificDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificDecreaseHook *IOperatorSpecificDecreaseHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificDecreaseHook.Contract.OnSlash(&_IOperatorSpecificDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
