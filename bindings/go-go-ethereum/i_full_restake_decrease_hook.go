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

// IFullRestakeDecreaseHookMetaData contains all meta data concerning the IFullRestakeDecreaseHook contract.
var IFullRestakeDecreaseHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"NotFullRestakeDelegator\",\"inputs\":[]}]",
}

// IFullRestakeDecreaseHookABI is the input ABI used to generate the binding from.
// Deprecated: Use IFullRestakeDecreaseHookMetaData.ABI instead.
var IFullRestakeDecreaseHookABI = IFullRestakeDecreaseHookMetaData.ABI

// IFullRestakeDecreaseHook is an auto generated Go binding around an Ethereum contract.
type IFullRestakeDecreaseHook struct {
	IFullRestakeDecreaseHookCaller     // Read-only binding to the contract
	IFullRestakeDecreaseHookTransactor // Write-only binding to the contract
	IFullRestakeDecreaseHookFilterer   // Log filterer for contract events
}

// IFullRestakeDecreaseHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type IFullRestakeDecreaseHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeDecreaseHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type IFullRestakeDecreaseHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeDecreaseHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type IFullRestakeDecreaseHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeDecreaseHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type IFullRestakeDecreaseHookSession struct {
	Contract     *IFullRestakeDecreaseHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts             // Call options to use throughout this session
	TransactOpts bind.TransactOpts         // Transaction auth options to use throughout this session
}

// IFullRestakeDecreaseHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type IFullRestakeDecreaseHookCallerSession struct {
	Contract *IFullRestakeDecreaseHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                   // Call options to use throughout this session
}

// IFullRestakeDecreaseHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type IFullRestakeDecreaseHookTransactorSession struct {
	Contract     *IFullRestakeDecreaseHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                   // Transaction auth options to use throughout this session
}

// IFullRestakeDecreaseHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type IFullRestakeDecreaseHookRaw struct {
	Contract *IFullRestakeDecreaseHook // Generic contract binding to access the raw methods on
}

// IFullRestakeDecreaseHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type IFullRestakeDecreaseHookCallerRaw struct {
	Contract *IFullRestakeDecreaseHookCaller // Generic read-only contract binding to access the raw methods on
}

// IFullRestakeDecreaseHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type IFullRestakeDecreaseHookTransactorRaw struct {
	Contract *IFullRestakeDecreaseHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewIFullRestakeDecreaseHook creates a new instance of IFullRestakeDecreaseHook, bound to a specific deployed contract.
func NewIFullRestakeDecreaseHook(address common.Address, backend bind.ContractBackend) (*IFullRestakeDecreaseHook, error) {
	contract, err := bindIFullRestakeDecreaseHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeDecreaseHook{IFullRestakeDecreaseHookCaller: IFullRestakeDecreaseHookCaller{contract: contract}, IFullRestakeDecreaseHookTransactor: IFullRestakeDecreaseHookTransactor{contract: contract}, IFullRestakeDecreaseHookFilterer: IFullRestakeDecreaseHookFilterer{contract: contract}}, nil
}

// NewIFullRestakeDecreaseHookCaller creates a new read-only instance of IFullRestakeDecreaseHook, bound to a specific deployed contract.
func NewIFullRestakeDecreaseHookCaller(address common.Address, caller bind.ContractCaller) (*IFullRestakeDecreaseHookCaller, error) {
	contract, err := bindIFullRestakeDecreaseHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeDecreaseHookCaller{contract: contract}, nil
}

// NewIFullRestakeDecreaseHookTransactor creates a new write-only instance of IFullRestakeDecreaseHook, bound to a specific deployed contract.
func NewIFullRestakeDecreaseHookTransactor(address common.Address, transactor bind.ContractTransactor) (*IFullRestakeDecreaseHookTransactor, error) {
	contract, err := bindIFullRestakeDecreaseHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeDecreaseHookTransactor{contract: contract}, nil
}

// NewIFullRestakeDecreaseHookFilterer creates a new log filterer instance of IFullRestakeDecreaseHook, bound to a specific deployed contract.
func NewIFullRestakeDecreaseHookFilterer(address common.Address, filterer bind.ContractFilterer) (*IFullRestakeDecreaseHookFilterer, error) {
	contract, err := bindIFullRestakeDecreaseHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeDecreaseHookFilterer{contract: contract}, nil
}

// bindIFullRestakeDecreaseHook binds a generic wrapper to an already deployed contract.
func bindIFullRestakeDecreaseHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := IFullRestakeDecreaseHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IFullRestakeDecreaseHook.Contract.IFullRestakeDecreaseHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.IFullRestakeDecreaseHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.IFullRestakeDecreaseHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IFullRestakeDecreaseHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.contract.Transact(opts, method, params...)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.OnSlash(&_IFullRestakeDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeDecreaseHook *IFullRestakeDecreaseHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeDecreaseHook.Contract.OnSlash(&_IFullRestakeDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
