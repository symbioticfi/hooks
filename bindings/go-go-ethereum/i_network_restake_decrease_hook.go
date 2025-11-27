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

// INetworkRestakeDecreaseHookMetaData contains all meta data concerning the INetworkRestakeDecreaseHook contract.
var INetworkRestakeDecreaseHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"NotNetworkRestakeDelegator\",\"inputs\":[]}]",
}

// INetworkRestakeDecreaseHookABI is the input ABI used to generate the binding from.
// Deprecated: Use INetworkRestakeDecreaseHookMetaData.ABI instead.
var INetworkRestakeDecreaseHookABI = INetworkRestakeDecreaseHookMetaData.ABI

// INetworkRestakeDecreaseHook is an auto generated Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHook struct {
	INetworkRestakeDecreaseHookCaller     // Read-only binding to the contract
	INetworkRestakeDecreaseHookTransactor // Write-only binding to the contract
	INetworkRestakeDecreaseHookFilterer   // Log filterer for contract events
}

// INetworkRestakeDecreaseHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeDecreaseHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeDecreaseHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type INetworkRestakeDecreaseHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeDecreaseHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type INetworkRestakeDecreaseHookSession struct {
	Contract     *INetworkRestakeDecreaseHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts                // Call options to use throughout this session
	TransactOpts bind.TransactOpts            // Transaction auth options to use throughout this session
}

// INetworkRestakeDecreaseHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type INetworkRestakeDecreaseHookCallerSession struct {
	Contract *INetworkRestakeDecreaseHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                      // Call options to use throughout this session
}

// INetworkRestakeDecreaseHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type INetworkRestakeDecreaseHookTransactorSession struct {
	Contract     *INetworkRestakeDecreaseHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                      // Transaction auth options to use throughout this session
}

// INetworkRestakeDecreaseHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHookRaw struct {
	Contract *INetworkRestakeDecreaseHook // Generic contract binding to access the raw methods on
}

// INetworkRestakeDecreaseHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHookCallerRaw struct {
	Contract *INetworkRestakeDecreaseHookCaller // Generic read-only contract binding to access the raw methods on
}

// INetworkRestakeDecreaseHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type INetworkRestakeDecreaseHookTransactorRaw struct {
	Contract *INetworkRestakeDecreaseHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewINetworkRestakeDecreaseHook creates a new instance of INetworkRestakeDecreaseHook, bound to a specific deployed contract.
func NewINetworkRestakeDecreaseHook(address common.Address, backend bind.ContractBackend) (*INetworkRestakeDecreaseHook, error) {
	contract, err := bindINetworkRestakeDecreaseHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeDecreaseHook{INetworkRestakeDecreaseHookCaller: INetworkRestakeDecreaseHookCaller{contract: contract}, INetworkRestakeDecreaseHookTransactor: INetworkRestakeDecreaseHookTransactor{contract: contract}, INetworkRestakeDecreaseHookFilterer: INetworkRestakeDecreaseHookFilterer{contract: contract}}, nil
}

// NewINetworkRestakeDecreaseHookCaller creates a new read-only instance of INetworkRestakeDecreaseHook, bound to a specific deployed contract.
func NewINetworkRestakeDecreaseHookCaller(address common.Address, caller bind.ContractCaller) (*INetworkRestakeDecreaseHookCaller, error) {
	contract, err := bindINetworkRestakeDecreaseHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeDecreaseHookCaller{contract: contract}, nil
}

// NewINetworkRestakeDecreaseHookTransactor creates a new write-only instance of INetworkRestakeDecreaseHook, bound to a specific deployed contract.
func NewINetworkRestakeDecreaseHookTransactor(address common.Address, transactor bind.ContractTransactor) (*INetworkRestakeDecreaseHookTransactor, error) {
	contract, err := bindINetworkRestakeDecreaseHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeDecreaseHookTransactor{contract: contract}, nil
}

// NewINetworkRestakeDecreaseHookFilterer creates a new log filterer instance of INetworkRestakeDecreaseHook, bound to a specific deployed contract.
func NewINetworkRestakeDecreaseHookFilterer(address common.Address, filterer bind.ContractFilterer) (*INetworkRestakeDecreaseHookFilterer, error) {
	contract, err := bindINetworkRestakeDecreaseHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeDecreaseHookFilterer{contract: contract}, nil
}

// bindINetworkRestakeDecreaseHook binds a generic wrapper to an already deployed contract.
func bindINetworkRestakeDecreaseHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := INetworkRestakeDecreaseHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeDecreaseHook.Contract.INetworkRestakeDecreaseHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.INetworkRestakeDecreaseHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.INetworkRestakeDecreaseHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeDecreaseHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.contract.Transact(opts, method, params...)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.OnSlash(&_INetworkRestakeDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeDecreaseHook *INetworkRestakeDecreaseHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeDecreaseHook.Contract.OnSlash(&_INetworkRestakeDecreaseHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
