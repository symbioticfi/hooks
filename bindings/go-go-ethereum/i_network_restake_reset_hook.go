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

// INetworkRestakeResetHookMetaData contains all meta data concerning the INetworkRestakeResetHook contract.
var INetworkRestakeResetHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"PERIOD\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint48\",\"internalType\":\"uint48\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"SLASH_COUNT\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"InvalidSlashCount\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotNetworkRestakeDelegator\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotVaultDelegator\",\"inputs\":[]}]",
}

// INetworkRestakeResetHookABI is the input ABI used to generate the binding from.
// Deprecated: Use INetworkRestakeResetHookMetaData.ABI instead.
var INetworkRestakeResetHookABI = INetworkRestakeResetHookMetaData.ABI

// INetworkRestakeResetHook is an auto generated Go binding around an Ethereum contract.
type INetworkRestakeResetHook struct {
	INetworkRestakeResetHookCaller     // Read-only binding to the contract
	INetworkRestakeResetHookTransactor // Write-only binding to the contract
	INetworkRestakeResetHookFilterer   // Log filterer for contract events
}

// INetworkRestakeResetHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type INetworkRestakeResetHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeResetHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type INetworkRestakeResetHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeResetHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type INetworkRestakeResetHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// INetworkRestakeResetHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type INetworkRestakeResetHookSession struct {
	Contract     *INetworkRestakeResetHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts             // Call options to use throughout this session
	TransactOpts bind.TransactOpts         // Transaction auth options to use throughout this session
}

// INetworkRestakeResetHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type INetworkRestakeResetHookCallerSession struct {
	Contract *INetworkRestakeResetHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                   // Call options to use throughout this session
}

// INetworkRestakeResetHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type INetworkRestakeResetHookTransactorSession struct {
	Contract     *INetworkRestakeResetHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                   // Transaction auth options to use throughout this session
}

// INetworkRestakeResetHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type INetworkRestakeResetHookRaw struct {
	Contract *INetworkRestakeResetHook // Generic contract binding to access the raw methods on
}

// INetworkRestakeResetHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type INetworkRestakeResetHookCallerRaw struct {
	Contract *INetworkRestakeResetHookCaller // Generic read-only contract binding to access the raw methods on
}

// INetworkRestakeResetHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type INetworkRestakeResetHookTransactorRaw struct {
	Contract *INetworkRestakeResetHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewINetworkRestakeResetHook creates a new instance of INetworkRestakeResetHook, bound to a specific deployed contract.
func NewINetworkRestakeResetHook(address common.Address, backend bind.ContractBackend) (*INetworkRestakeResetHook, error) {
	contract, err := bindINetworkRestakeResetHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeResetHook{INetworkRestakeResetHookCaller: INetworkRestakeResetHookCaller{contract: contract}, INetworkRestakeResetHookTransactor: INetworkRestakeResetHookTransactor{contract: contract}, INetworkRestakeResetHookFilterer: INetworkRestakeResetHookFilterer{contract: contract}}, nil
}

// NewINetworkRestakeResetHookCaller creates a new read-only instance of INetworkRestakeResetHook, bound to a specific deployed contract.
func NewINetworkRestakeResetHookCaller(address common.Address, caller bind.ContractCaller) (*INetworkRestakeResetHookCaller, error) {
	contract, err := bindINetworkRestakeResetHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeResetHookCaller{contract: contract}, nil
}

// NewINetworkRestakeResetHookTransactor creates a new write-only instance of INetworkRestakeResetHook, bound to a specific deployed contract.
func NewINetworkRestakeResetHookTransactor(address common.Address, transactor bind.ContractTransactor) (*INetworkRestakeResetHookTransactor, error) {
	contract, err := bindINetworkRestakeResetHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeResetHookTransactor{contract: contract}, nil
}

// NewINetworkRestakeResetHookFilterer creates a new log filterer instance of INetworkRestakeResetHook, bound to a specific deployed contract.
func NewINetworkRestakeResetHookFilterer(address common.Address, filterer bind.ContractFilterer) (*INetworkRestakeResetHookFilterer, error) {
	contract, err := bindINetworkRestakeResetHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &INetworkRestakeResetHookFilterer{contract: contract}, nil
}

// bindINetworkRestakeResetHook binds a generic wrapper to an already deployed contract.
func bindINetworkRestakeResetHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := INetworkRestakeResetHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeResetHook.Contract.INetworkRestakeResetHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.INetworkRestakeResetHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.INetworkRestakeResetHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _INetworkRestakeResetHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_INetworkRestakeResetHook *INetworkRestakeResetHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.contract.Transact(opts, method, params...)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookCaller) PERIOD(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _INetworkRestakeResetHook.contract.Call(opts, &out, "PERIOD")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookSession) PERIOD() (*big.Int, error) {
	return _INetworkRestakeResetHook.Contract.PERIOD(&_INetworkRestakeResetHook.CallOpts)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookCallerSession) PERIOD() (*big.Int, error) {
	return _INetworkRestakeResetHook.Contract.PERIOD(&_INetworkRestakeResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookCaller) SLASHCOUNT(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _INetworkRestakeResetHook.contract.Call(opts, &out, "SLASH_COUNT")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookSession) SLASHCOUNT() (*big.Int, error) {
	return _INetworkRestakeResetHook.Contract.SLASHCOUNT(&_INetworkRestakeResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_INetworkRestakeResetHook *INetworkRestakeResetHookCallerSession) SLASHCOUNT() (*big.Int, error) {
	return _INetworkRestakeResetHook.Contract.SLASHCOUNT(&_INetworkRestakeResetHook.CallOpts)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeResetHook *INetworkRestakeResetHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeResetHook *INetworkRestakeResetHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.OnSlash(&_INetworkRestakeResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_INetworkRestakeResetHook *INetworkRestakeResetHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _INetworkRestakeResetHook.Contract.OnSlash(&_INetworkRestakeResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
