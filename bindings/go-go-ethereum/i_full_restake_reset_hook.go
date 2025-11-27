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

// IFullRestakeResetHookMetaData contains all meta data concerning the IFullRestakeResetHook contract.
var IFullRestakeResetHookMetaData = &bind.MetaData{
	ABI: "[{\"type\":\"function\",\"name\":\"PERIOD\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint48\",\"internalType\":\"uint48\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"SLASH_COUNT\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"onSlash\",\"inputs\":[{\"name\":\"subnetwork\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"operator\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"amount\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"captureTimestamp\",\"type\":\"uint48\",\"internalType\":\"uint48\"},{\"name\":\"data\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"error\",\"name\":\"InvalidSlashCount\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotFullRestakeDelegator\",\"inputs\":[]},{\"type\":\"error\",\"name\":\"NotVaultDelegator\",\"inputs\":[]}]",
}

// IFullRestakeResetHookABI is the input ABI used to generate the binding from.
// Deprecated: Use IFullRestakeResetHookMetaData.ABI instead.
var IFullRestakeResetHookABI = IFullRestakeResetHookMetaData.ABI

// IFullRestakeResetHook is an auto generated Go binding around an Ethereum contract.
type IFullRestakeResetHook struct {
	IFullRestakeResetHookCaller     // Read-only binding to the contract
	IFullRestakeResetHookTransactor // Write-only binding to the contract
	IFullRestakeResetHookFilterer   // Log filterer for contract events
}

// IFullRestakeResetHookCaller is an auto generated read-only Go binding around an Ethereum contract.
type IFullRestakeResetHookCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeResetHookTransactor is an auto generated write-only Go binding around an Ethereum contract.
type IFullRestakeResetHookTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeResetHookFilterer is an auto generated log filtering Go binding around an Ethereum contract events.
type IFullRestakeResetHookFilterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// IFullRestakeResetHookSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type IFullRestakeResetHookSession struct {
	Contract     *IFullRestakeResetHook // Generic contract binding to set the session for
	CallOpts     bind.CallOpts          // Call options to use throughout this session
	TransactOpts bind.TransactOpts      // Transaction auth options to use throughout this session
}

// IFullRestakeResetHookCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type IFullRestakeResetHookCallerSession struct {
	Contract *IFullRestakeResetHookCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts                // Call options to use throughout this session
}

// IFullRestakeResetHookTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type IFullRestakeResetHookTransactorSession struct {
	Contract     *IFullRestakeResetHookTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts                // Transaction auth options to use throughout this session
}

// IFullRestakeResetHookRaw is an auto generated low-level Go binding around an Ethereum contract.
type IFullRestakeResetHookRaw struct {
	Contract *IFullRestakeResetHook // Generic contract binding to access the raw methods on
}

// IFullRestakeResetHookCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type IFullRestakeResetHookCallerRaw struct {
	Contract *IFullRestakeResetHookCaller // Generic read-only contract binding to access the raw methods on
}

// IFullRestakeResetHookTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type IFullRestakeResetHookTransactorRaw struct {
	Contract *IFullRestakeResetHookTransactor // Generic write-only contract binding to access the raw methods on
}

// NewIFullRestakeResetHook creates a new instance of IFullRestakeResetHook, bound to a specific deployed contract.
func NewIFullRestakeResetHook(address common.Address, backend bind.ContractBackend) (*IFullRestakeResetHook, error) {
	contract, err := bindIFullRestakeResetHook(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeResetHook{IFullRestakeResetHookCaller: IFullRestakeResetHookCaller{contract: contract}, IFullRestakeResetHookTransactor: IFullRestakeResetHookTransactor{contract: contract}, IFullRestakeResetHookFilterer: IFullRestakeResetHookFilterer{contract: contract}}, nil
}

// NewIFullRestakeResetHookCaller creates a new read-only instance of IFullRestakeResetHook, bound to a specific deployed contract.
func NewIFullRestakeResetHookCaller(address common.Address, caller bind.ContractCaller) (*IFullRestakeResetHookCaller, error) {
	contract, err := bindIFullRestakeResetHook(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeResetHookCaller{contract: contract}, nil
}

// NewIFullRestakeResetHookTransactor creates a new write-only instance of IFullRestakeResetHook, bound to a specific deployed contract.
func NewIFullRestakeResetHookTransactor(address common.Address, transactor bind.ContractTransactor) (*IFullRestakeResetHookTransactor, error) {
	contract, err := bindIFullRestakeResetHook(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeResetHookTransactor{contract: contract}, nil
}

// NewIFullRestakeResetHookFilterer creates a new log filterer instance of IFullRestakeResetHook, bound to a specific deployed contract.
func NewIFullRestakeResetHookFilterer(address common.Address, filterer bind.ContractFilterer) (*IFullRestakeResetHookFilterer, error) {
	contract, err := bindIFullRestakeResetHook(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &IFullRestakeResetHookFilterer{contract: contract}, nil
}

// bindIFullRestakeResetHook binds a generic wrapper to an already deployed contract.
func bindIFullRestakeResetHook(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := IFullRestakeResetHookMetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IFullRestakeResetHook *IFullRestakeResetHookRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IFullRestakeResetHook.Contract.IFullRestakeResetHookCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IFullRestakeResetHook *IFullRestakeResetHookRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.IFullRestakeResetHookTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IFullRestakeResetHook *IFullRestakeResetHookRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.IFullRestakeResetHookTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_IFullRestakeResetHook *IFullRestakeResetHookCallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _IFullRestakeResetHook.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_IFullRestakeResetHook *IFullRestakeResetHookTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_IFullRestakeResetHook *IFullRestakeResetHookTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.contract.Transact(opts, method, params...)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IFullRestakeResetHook *IFullRestakeResetHookCaller) PERIOD(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _IFullRestakeResetHook.contract.Call(opts, &out, "PERIOD")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IFullRestakeResetHook *IFullRestakeResetHookSession) PERIOD() (*big.Int, error) {
	return _IFullRestakeResetHook.Contract.PERIOD(&_IFullRestakeResetHook.CallOpts)
}

// PERIOD is a free data retrieval call binding the contract method 0xb4d1d795.
//
// Solidity: function PERIOD() view returns(uint48)
func (_IFullRestakeResetHook *IFullRestakeResetHookCallerSession) PERIOD() (*big.Int, error) {
	return _IFullRestakeResetHook.Contract.PERIOD(&_IFullRestakeResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IFullRestakeResetHook *IFullRestakeResetHookCaller) SLASHCOUNT(opts *bind.CallOpts) (*big.Int, error) {
	var out []interface{}
	err := _IFullRestakeResetHook.contract.Call(opts, &out, "SLASH_COUNT")

	if err != nil {
		return *new(*big.Int), err
	}

	out0 := *abi.ConvertType(out[0], new(*big.Int)).(**big.Int)

	return out0, err

}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IFullRestakeResetHook *IFullRestakeResetHookSession) SLASHCOUNT() (*big.Int, error) {
	return _IFullRestakeResetHook.Contract.SLASHCOUNT(&_IFullRestakeResetHook.CallOpts)
}

// SLASHCOUNT is a free data retrieval call binding the contract method 0xd524c328.
//
// Solidity: function SLASH_COUNT() view returns(uint256)
func (_IFullRestakeResetHook *IFullRestakeResetHookCallerSession) SLASHCOUNT() (*big.Int, error) {
	return _IFullRestakeResetHook.Contract.SLASHCOUNT(&_IFullRestakeResetHook.CallOpts)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeResetHook *IFullRestakeResetHookTransactor) OnSlash(opts *bind.TransactOpts, subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeResetHook.contract.Transact(opts, "onSlash", subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeResetHook *IFullRestakeResetHookSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.OnSlash(&_IFullRestakeResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}

// OnSlash is a paid mutator transaction binding the contract method 0xe49561ee.
//
// Solidity: function onSlash(bytes32 subnetwork, address operator, uint256 amount, uint48 captureTimestamp, bytes data) returns()
func (_IFullRestakeResetHook *IFullRestakeResetHookTransactorSession) OnSlash(subnetwork [32]byte, operator common.Address, amount *big.Int, captureTimestamp *big.Int, data []byte) (*types.Transaction, error) {
	return _IFullRestakeResetHook.Contract.OnSlash(&_IFullRestakeResetHook.TransactOpts, subnetwork, operator, amount, captureTimestamp, data)
}
