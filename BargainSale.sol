// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

 
contract BargainSale {    
    
    //state variables
    uint256 public productCount;
    string public productName;
    string public productImage;
    
    
    event Transfer(address from, uint amount, uint256 timestamp);
  
    //we define the product details
    constructor(uint stock, string memory  imagePath, string memory name){
        productCount = stock;
        productName = name;
        productImage = imagePath;
   
    }

    //variable for transaction
    struct SaleStruct {
        address sender;
        uint amount;
        uint256 timestamp;
    }
 
    //array
    SaleStruct[] sales;


   // modifier for checking is stock enough
    modifier CheckStock(uint amount){
        require(productCount > amount ,"Your order is out of stock!");
        _;
    }


    //main function
    //transaction pushing, ethers transfer, update the product count
    function addToBlockchain(uint amount, address payable to) CheckStock(amount) external payable {
        
        require(amount < 3, "You can order max 2 products!");
        sales.push(SaleStruct(msg.sender, amount, block.timestamp));
         
        to.transfer(msg.value);
        productCount = productCount - amount;

        emit Transfer(msg.sender, amount, block.timestamp);

    }


    //get all sale transactions
    function getAllSales() public view returns (SaleStruct[] memory) {
        return sales;
    }


    //available count for immediate sale product
    function getProductCount() public view returns (uint256) {
        return productCount;
    }


} 

  