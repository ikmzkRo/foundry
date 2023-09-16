// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19; // 汎用的(様々なチェーンに展開することを想定)

import {Ownable} from "openzeppelin/access/Ownable.sol";
import {Strings} from "openzeppelin/utils/Strings.sol";

contract Simple is Ownable {
    using Strings for uint256; // uint256の変数にStringsライブラリの機能を付与する
    uint256 private value;

    // ブロックチェーンにデプロイするタイミングで実行される
    constructor(uint256 _value) {
        value = _value;
    }

    // public、external関数は、インターネットがつながる場所なら誰でも実行できる
    // 本コントラクトをデプロイしたウォレットの秘密鍵でのみ実行できるようにしたい
    function setValue(uint256 _value) onlyOwner()
    public {
        value = _value;
    }

    // 数値→文字列変換する関数。内部プロパティは変更しないので関数修飾子は view
    // 一時的にメモリ領域に保存する変更可能な値なので変数修飾子は memory 
    function getValue() public view 
    returns (string memory) {
        return value.toString();
    }
}
