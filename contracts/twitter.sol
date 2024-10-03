// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract twitter{
    struct tweet{
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint likes;
    }

    mapping (address => tweet[]) tweets;

    address public owner;

    event tweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event tweetLiked(address liker, address tweetAuthor, uint256 id, uint256 newLikeCount);
    event tweetUnLiked(address unliker, address tweetAuthor, uint256 id, uint256 newLikeCount);

    constructor() {
        owner = msg.sender;
    }

    function createTweet(string memory _msg) public {

        tweet memory NewTweet = tweet({
            id : tweets[msg.sender].length,
            author : msg.sender,
            content : _msg,
            timestamp : block.timestamp,
            likes : 0
        });

        tweets[msg.sender].push(NewTweet);

        emit tweetCreated(NewTweet.id, NewTweet.author, NewTweet.content, NewTweet.timestamp);

    }

    function likeTweet(address author, uint256 id) external {  
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");

        tweets[author][id].likes++;

        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes);

    }

    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST");
        require(tweets[author][id].likes > 0, "TWEET HAS NO LIKES");
        
        tweets[author][id].likes--;
        emit tweetUnLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTweet( uint _i) public view returns (tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (tweet[] memory ){
        return tweets[_owner];
    }
}