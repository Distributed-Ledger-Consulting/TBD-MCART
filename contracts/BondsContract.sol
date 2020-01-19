pragma solidity 0.5.1;

import "./SafeMath.sol";
import "./ERC20Interface.sol";
import "./EuroClaimTokenContract.sol";
import "./WhitelistContract.sol";
import "./Ownable.sol";


contract BondsContract is ERC20Interface, Ownable {
    using SafeMath for uint256;

    WhitelistContract _whitelist;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    mapping (address => uint256) private _unlockDate;

    uint256 private _totalSupply;
    uint256 private _maxSupplyCap;
    uint256 private _minPurchaseAmount;
    uint256 private _lockupPeriod;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    string public _document;

    address private _claimTokenAddress;

    bool public frozen;

    constructor (WhitelistContract whitelist, string memory document, uint256 maxSupplyCap, uint256 minPurchaseAmount) public {
        _name = "Most Compliant and Regulated Token";
        _symbol = "MCART";
        _decimals = 18;
        _whitelist = whitelist;
        _document = document;
        _maxSupplyCap = maxSupplyCap;
        _minPurchaseAmount = minPurchaseAmount;
    }


    function setClaimTokenAddress(address _address) public onlyOwner {
        _claimTokenAddress = _address;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }


    function forceTransfer(address source, address recipient, uint256 amount) public onlyOwner returns (bool) {
        _transfer(source, recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

   
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(!frozen);
        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     */
    function _issue(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: issue to the zero address");
        require(!frozen);
        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        require(_totalSupply <= _maxSupplyCap);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     */
    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        require(!frozen);
        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
     */
    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function issue(address account, uint256 amount) public onlyOwner {
        _issue(account, amount);
    }
    

    function distribute(uint256 amount) public {

    }

    function freeze(string memory message, uint256 freeze_document) public onlyOwner {
        frozen=true;
    }

    function buyToken(uint256 amount) public {
        require(_whitelist.isWhitelisted(msg.sender));
        require(EuroClaimTokenContract(_claimTokenAddress).transferFrom(msg.sender, address(this), amount));

        if(_unlockDate[msg.sender] == 0) {
            require(amount >= _minPurchaseAmount);

            // set lockup (14 days)
            _unlockDate[msg.sender] = now + (14 days);
        }

        _issue(msg.sender, amount);
        EuroClaimTokenContract(_claimTokenAddress).burn(amount);
    }

    function sellToken(uint256 amount) public {
        require(_whitelist.isWhitelisted(msg.sender));
        require(_unlockDate[msg.sender] < now);

        _burn(msg.sender, amount);
        EuroClaimTokenContract(_claimTokenAddress).issue(msg.sender, amount);
    }

    function revokeInvestment() public {
        require(_whitelist.isWhitelisted(msg.sender));
        require(_unlockDate[msg.sender] > now);
        // calculate interest
        uint256 amount = _balances[msg.sender];
        _burn(msg.sender, amount);
        EuroClaimTokenContract(_claimTokenAddress).issue(msg.sender, amount);
    }

}
