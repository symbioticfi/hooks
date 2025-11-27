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

// IOperatorSpecificResetHookMetaData contains all meta data concerning the IOperatorSpecificResetHook contract.
var IOperatorSpecificResetHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"PERIOD\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint48\",\"internalType\":\"uint48\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"SLASH_COUNT\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"InvalidSlashCount\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotOperatorSpecificDelegator\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotVaultDelegator\",\"inputs\":[]}]",
}

// IOperatorSpecificResetHookABI is the input ABI used to generate the binding from.
// Deprecated: Use IOperatorSpecificResetHookMetaData.ABI instead.
var IOperatorSpecificResetHookABI = IOperatorSpecificResetHookMetaData.ABI

// IOperatorSpecificResetHook is an auto generated Go binding around an Ethereum contract.
type IOperatorSpecificResetHook struct {
	IOperatorSpecificResetHookCaller     // Read-only binding to the contract
	IOperatorSpecificResetHookTransactor // Write-only binding to the contract
	IOperatorSpecificResetHookFilterer   // Log filterer for contract events
}

// IOperatorSpecificResetHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type IOperatorSpecificResetHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificResetHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type IOperatorSpecificResetHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificResetHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type IOperatorSpecificResetHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IOperatorSpecificResetHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type IOperatorSpecificResetHookSession struct {
	Contract     *IOperatorSpecificResetHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts               // Call options to use throughout this session
	TransactOpts bind.TransactOpts           // Transaction auth options to use throughout this session
}

// IOperatorSpecificResetHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type IOperatorSpecificResetHookCallerSession struct {
	Contract *IOperatorSpecificResetHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                     // Call options to use throughout this session
}

// IOperatorSpecificResetHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type IOperatorSpecificResetHookTransactorSession struct {
	Contract     *IOperatorSpecificResetHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                     // Transaction auth options to use throughout this session
}

// IOperatorSpecificResetHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type IOperatorSpecificResetHookRaw struct {
	Contract *IOperatorSpecificResetHook // Generic contract binding to access the raw methods on
}

// IOperatorSpecificResetHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type IOperatorSpecificResetHookCallerRaw struct {
	Contract *IOperatorSpecificResetHookCaller // Generic read-only contract binding to access the raw methods on
}

// IOperatorSpecificResetHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type IOperatorSpecificResetHookTransactorRaw struct {
	Contract *IOperatorSpecificResetHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewIOperatorSpecificResetHook creates a new instance of IOperatorSpecificResetHook, bound to a specific deployed contract.
func NewIOperatorSpecificResetHook(address common.Address, backend bind.ContractBackend) (*IOperatorSpecificResetHook, error) {
	contract, err := bindIOperatorSpecificResetHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificResetHook{IOperatorSpecificResetHookCaller: IOperatorSpecificResetHookCaller{contract: contract}, IOperatorSpecificResetHookTransactor: IOperatorSpecificResetHookTransactor{contract: contract}, IOperatorSpecificResetHookFilterer: IOperatorSpecificResetHookFilterer{contract: contract}}, nil
}

// NewIOperatorSpecificResetHookCaller creates a new read-only instance of IOperatorSpecificResetHook, bound to a specific deployed contract.
func NewIOperatorSpecificResetHookCaller(address common.Address, caller bind.ContractCaller) (*IOperatorSpecificResetHookCaller, error) {
	contract, err := bindIOperatorSpecificResetHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificResetHookCaller{contract: contract}, nil
}

// NewIOperatorSpecificResetHookTransactor creates a new write-only instance of IOperatorSpecificResetHook, bound to a specific deployed contract.
func NewIOperatorSpecificResetHookTransactor(address common.Address, transactor bind.ContractTransactor) (*IOperatorSpecificResetHookTransactor, error) {
	contract, err := bindIOperatorSpecificResetHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificResetHookTransactor{contract: contract}, nil
}

// NewIOperatorSpecificResetHookFilterer creates a new log filterer instance of IOperatorSpecificResetHook, bound to a specific deployed contract.
func NewIOperatorSpecificResetHookFilterer(address common.Address, filterer bind.ContractFilterer) (*IOperatorSpecificResetHookFilterer, error) {
	contract, err := bindIOperatorSpecificResetHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &IOperatorSpecificResetHookFilterer{contract: contract}, nil
}

// bindIOperatorSpecificResetHook binds a generic wrapper to an already deployed contract.
func bindIOperatorSpecificResetHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := IOperatorSpecificResetHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IOperatorSpecificResetHook.Contract.IOperatorSpecificResetHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.IOperatorSpecificResetHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.IOperatorSpecificResetHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IOperatorSpecificResetHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.contract.Transact(opts, method, params...)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookCaller) PERIOD(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _IOperatorSpecificResetHook.contract.Call(opts, &out, "PERIOD")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookSession) PERIOD() (*big.Int, error) {
	return _IOperatorSpecificResetHook.Contract.PERIOD(&_IOperatorSpecificResetHook.CallOpts)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookCallerSession) PERIOD() (*big.Int, error) {
	return _IOperatorSpecificResetHook.Contract.PERIOD(&_IOperatorSpecificResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookCaller) SLASHCOUNT(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _IOperatorSpecificResetHook.contract.Call(opts, &out, "SLASH_COUNT")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookSession) SLASHCOUNT() (*big.Int, error) {
	return _IOperatorSpecificResetHook.Contract.SLASHCOUNT(&_IOperatorSpecificResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookCallerSession) SLASHCOUNT() (*big.Int, error) {
	return _IOperatorSpecificResetHook.Contract.SLASHCOUNT(&_IOperatorSpecificResetHook.CallOpts)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.OnSlash(&_IOperatorSpecificResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IOperatorSpecificResetHook *IOperatorSpecificResetHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IOperatorSpecificResetHook.Contract.OnSlash(&_IOperatorSpecificResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
