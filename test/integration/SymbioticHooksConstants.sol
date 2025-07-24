// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SymbioticHooksImports.sol";

library SymbioticHooksConstants {
    function networkRestakeDecreaseHook() internal view returns (address) {
        if (block.chainid == 1) {
            // mainnet
            return 0xe46d876BA2F3C991F3AC3321B8C0A1c323ef8bCf;
        } else if (block.chainid == 17_000) {
            // holesky
            return 0xe66fEC3e43ea682cF09A8E12433d90FfBDBF8E74;
        } else if (block.chainid == 11_155_111) {
            // sepolia
            return 0x4EeA7269BC42feA87B4E92F4E4f7bCAF3dC81875;
        } else if (block.chainid == 560_048) {
            // hoodi
            return 0x2C78B3A5de76161aee8e37d0E3b0E0EBb12BacCc;
        } else {
            revert("SymbioticHooksConstants.networkRestakeDecreaseHook(): chainid not supported");
        }
    }

    function networkRestakeRedistributeHook() internal view returns (address) {
        if (block.chainid == 1) {
            // mainnet
            return 0x8A76a3b791D9cfCD17304D31e04304A54Bf07845;
        } else if (block.chainid == 17_000) {
            // holesky
            return 0x30C46a40ed3DE2Fc997Ce58fB69FCE1f86a9205B;
        } else if (block.chainid == 11_155_111) {
            // sepolia
            return 0x5425D1604a4e01C34996cb662d831E0dEF66C210;
        } else if (block.chainid == 560_048) {
            // hoodi
            return 0x45B188aBE45820aE130A2844649Faeb225096596;
        } else {
            revert("SymbioticHooksConstants.networkRestakeRedistributeHook(): chainid not supported");
        }
    }

    function fullRestakeDecreaseHook() internal view returns (address) {
        if (block.chainid == 1) {
            // mainnet
            return 0x0786ef079A0Fc3A2D9e62bf2E8c7aeF86B62d70A;
        } else if (block.chainid == 17_000) {
            // holesky
            return 0x6Eb2768c9C47f4C05972A3311390830cB49f77A1;
        } else if (block.chainid == 11_155_111) {
            // sepolia
            return 0x088c40869954806Cd1580eda3C2d866104d0b118;
        } else if (block.chainid == 560_048) {
            // hoodi
            return 0x3224d9DF887ABdC10c1bCcECfd9EFC29A638a3E3;
        } else {
            revert("SymbioticHooksConstants.fullRestakeDecreaseHook(): chainid not supported");
        }
    }

    function operatorSpecificDecreaseHook() internal view returns (address) {
        if (block.chainid == 1) {
            // mainnet
            return 0xCc7Fd9B9A37ba1e2b30243Ce5A52BDB1f56B006a;
        } else if (block.chainid == 17_000) {
            // holesky
            return 0xCD72e26CccD001167BC7859D9daE459C7CFE6E31;
        } else if (block.chainid == 11_155_111) {
            // sepolia
            return 0xeae1fCEe58Bd5c3EE9185b34E9f4481faB8FA939;
        } else if (block.chainid == 560_048) {
            // hoodi
            return 0xF8ee812cc1E7C8eE94395E510098b36ff458E77d;
        } else {
            revert("SymbioticHooksConstants.operatorSpecificDecreaseHook(): chainid not supported");
        }
    }
}
