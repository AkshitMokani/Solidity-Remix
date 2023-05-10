// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Ecommerce
{
    struct product
    {
        string title;
        string description;
        address payable seller;
        uint price;
        uint productId;
        address buyer;
        bool delivered;
    }

    uint counter = 0;
    product[] public products;

    event Registered(string title,uint productId,address seller);
    event boughts(uint productId,address buyer);
    event deliver(uint productId);

    function registerProduct(string memory _title, string memory _description, uint _price) public 
    {
        require(_price > 0, "Price should be greater than zero");
        product memory tempProduct;

        tempProduct.title=_title;
        tempProduct.description=_description;
        tempProduct.price=_price*10**18; //1 ether = 10 ** 18
        tempProduct.seller=payable(msg.sender);
        tempProduct.productId=counter;
        products.push(tempProduct);
        counter++;

        emit Registered(_title,tempProduct.productId,msg.sender);
    }


    function buyProduct(uint _productId) payable public
    {
        require(products[_productId].price==msg.value,"Please pay exact amount");
        require(products[_productId].seller!=msg.sender,"Seller can't be the Buyer");
        products[_productId].buyer=msg.sender;
        emit boughts(_productId,msg.sender);
    }

    function delivery(uint _productId) public 
    {
        require(products[_productId].buyer==msg.sender,"Only Buyer can Confirm It");
        products[_productId].delivered=true;
        products[_productId].seller.transfer(products[_productId].price);
        emit deliver(_productId);
    }
}