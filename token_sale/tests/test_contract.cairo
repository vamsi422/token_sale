use starknet::ContractAddress;

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};
use token_sale::interfaces::itoken_sale::{ITokenSaleDispatcher,ITokenSaleDispatcherTrait};
use token_sale::interfaces::ierc20::{IERC20Dispatcher,IERC20DispatcherTrait};
use core::array::Array;
fn deploy_contract(name: ByteArray) -> ContractAddress {
    let owner: ContractAddress = 0x07ab19cdfc6981ad7beb769a71a2d1cdd52b3d8a148d367bbb79f18a170cd51.try_into().unwrap();
    let accepted_payment_token: ContractAddress = 0x03af13fcd9404f0ff7b75bae0b07f5ce3a1d6bdb84a8e333a3ffa.try_into().unwrap();
    let contract = declare(name).unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@array![owner.try_into().unwrap(),accepted_payment_token.try_into().unwrap()]).unwrap();
    contract_address
}

const ONE_E18:u256=1000000000000000000_u256;

#[test]
fn test_constructor(){
    let contract_address = deploy_contract("TokenSale");
    let token_sale = ITokenSaleDispatcher { contract_address };
    // passing this owner,accepted_payment_token to test constructor
    let owner: ContractAddress = 0x07ab19cdfc6981ad7beb769a71a2d1cdd52b3d8a148d367bbb79f18a170cd51.try_into().unwrap();
    let accepted_payment_token: ContractAddress = 0x03af13fcd9404f0ff7b75bae0b07f5ce3a1d6bdb84a8e333a3ffa.try_into().unwrap();

    let get_owner=token_sale.owner();
    let get_accepted_payment_token=token_sale.accepted_payment_token();

    assert(owner.try_into().unwrap()==get_owner,'owner mismatch');
    assert(accepted_payment_token.try_into().unwrap()==get_accepted_payment_token,'Payment token mismatch');


}

// #[test]
// fn test_check_available_token() {
//     let contract_address = deploy_contract("TokenSale");

//     let token_sale = ITokenSaleDispatcher { contract_address };


    
// }
// #[test]
// fn test_deposit_token(){
//     let contract_address = deploy_contract("TokenSale");
//     let token_sale = ITokenSaleDispatcher { contract_address };

// }
// #[test]
// fn test_buy_token(){
//     let contract_address = deploy_contract("TokenSale");
//     let token_sale = ITokenSaleDispatcher { contract_address };

// }
// #[test]
// fn test_upgrade(){
//     let contract_address = deploy_contract("TokenSale");
//     let token_sale = ITokenSaleDispatcher { contract_address };

// }