// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SecureMessaging {
    struct Message {
        address sender;
        address receiver;
        string encryptedText;
        uint256 timestamp;
    }

    mapping(address => Message[]) private messages;
    
    event MessageSent(address indexed sender, address indexed receiver, uint256 timestamp);

    function sendMessage(address _receiver, string memory _encryptedText) public {
        require(_receiver != address(0), "Invalid receiver address");
        require(bytes(_encryptedText).length > 0, "Message cannot be empty");
        
        messages[_receiver].push(Message({
            sender: msg.sender,
            receiver: _receiver,
            encryptedText: _encryptedText,
            timestamp: block.timestamp
        }));
        
        emit MessageSent(msg.sender, _receiver, block.timestamp);
    }

    function getMessages() public view returns (Message[] memory) {
        return messages[msg.sender];
    }
}
