// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;


library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "Addition");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Subtruction");
        uint c = a - b;
        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
            if (a == 0){
            return 0;
            }
            uint256 c = a * b;
            require (c / a == b);
            return c;
    }
    
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
            require(b > 0, "Division");
            uint256 c = a / b;
            return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0, "Modulus");
        return (a % b);
    }
}
contract MyToken{
    using SafeMath for uint;

    string public constant name = "MyToken";
    string public constant symbol = "MFT";
    uint8 public constant decimals = 2;

    uint public totalSupply;

    mapping (address => uint) balances;

    mapping (address => mapping(address => uint)) allowed;

    event Transfer(address indexed _from, address _to, uint _value);
    event Approval(address indexed _from, address _to, uint _value);

    function mint(address to, uint value) public{
        balances[to] = balances[to].add(value);
        totalSupply = totalSupply.add(value);
    }

    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }

    function allowance(address _owner, address _spender) public view returns(uint){
        return allowed[_owner][_spender];
    }

    function transfer(address _to, uint _value) public{
        require(balances[msg.sender] >= _value);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint _value) public{
        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
    }
    
    function approve(address _spender, uint _value) public{
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }
}
