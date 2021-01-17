
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DubaiToken is ERC20,ERC20Burnable,ERC20Pausable,Ownable {
    bool private _paused;
    uint256 _initialSupply;
    address _owner;
    uint256 _cap;
    uint256 price;
    uint256 internal lockTransaction;
    event lockTransactionUntil(uint256);
    
    constructor() public ERC20("Dubai Token", "DXB")  {
        _owner = msg.sender;
        //_setupDecimals(8);
        _initialSupply =  5500000000000 * (10 ** uint256(decimals()));
        _cap = _initialSupply.mul(2);
        _mint(_owner, _initialSupply);
        _paused = false;
        price = 1678244195127500 wei;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20,ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);

        require(!paused(), "ERC20Pausable: token transfer while paused");
        if (from == address(0)) { // When minting tokens
            require(totalSupply().add(amount) <= _cap, "ERC20Capped: Token Generation fail, Amount");
        }
         require(lockTransaction < now, "transaction is currently locked");
    }

    function pauseToken() public onlyOwner returns (bool) {
        _pause();
        return true;
    }

    function unpauseToken() public onlyOwner returns (bool) {
        _unpause();
        return true;
    }
    function _approve(address owner, address spender, uint256 amount) internal virtual override{
        require(_balances[_owner] >= amount,"Approval: Not Enough balance for Allowance");
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function approve(address spender, uint256 amount) public onlyOwner override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public onlyOwner override returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true; 
    }
    function decreaseAllowance(address spender, uint256 subtractedValue) public override onlyOwner returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function generateTokens(address account, uint256 amount)
        public
        onlyOwner
        returns (bool)
    {
        _mint(account, amount);
        return true;
    }
    function _burn(address account, uint256 amount) internal onlyOwner override{
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
    function BuyToken() public payable returns (bool) {
        require(msg.value > 0 ether, "invailed amount");
        require(tx.origin == msg.sender, "should be external owned account");
        uint256 wei_unit = (10 ** uint256(decimals())).div(price);
        uint256 final_price = msg.value * wei_unit;
        _transfer(_owner,msg.sender,final_price);
        address(uint160(_owner)).transfer(msg.value);
        return true;
        }
    function setTokenPrice(uint256 _price) public onlyOwner returns(bool) {
            price = _price;
            return true;
    }
    function lock_transaction(uint256 time) onlyOwner public{
        require(time > 0 && time > now ,"Invalid Time: time must be greater current");
        lockTransaction = time;
        emit lockTransactionUntil(time);
    }
    receive() payable external{
        BuyToken();
    }
    
    fallback() payable external{
        BuyToken();
    }
}

