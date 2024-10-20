class BankAccount {
  final String _accountNumber;
  final String _accountHolderName;
  double _balance;

  BankAccount(this._accountNumber, this._accountHolderName, this._balance) {
    if (_balance < 0) {
      throw ArgumentError('Initial balance cannot be negative.');
    }
  }

  String get accountNumber => _accountNumber;
  String get accountHolderName => _accountHolderName;
  double get balance => _balance;

  
  void deposit(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Deposit amount must be positive.');
    }
    _balance += amount;
  }

  
  void withdraw(double amount) {
    if (amount <= 0) {
      throw ArgumentError('Withdrawal amount must be positive.');
    }
    if (amount <= _balance) {
      _balance -= amount;
    } else {
      throw Exception('Insufficient funds');
    }
  }
  @override
  String toString() {
    return 'Account Holder: $_accountHolderName, Account Number: $_accountNumber, Balance: \$${_balance.toStringAsFixed(2)}';
  }
}
class Bank {
  final String bankName;
  final String address;
  final String bankCode;
  final Map<String, BankAccount> _accounts = {}; 

  Bank(this.bankName, this.address, this.bankCode);

  
  BankAccount createAccount(String accountHolderName, double initialBalance) {
    String accountNumber = _generateUniqueAccountNumber();
    BankAccount newAccount = BankAccount(accountNumber, accountHolderName, initialBalance);
    _accounts[accountNumber] = newAccount;
    print('Account created for $accountHolderName with Account Number: $accountNumber');
    return newAccount;
  }

  
  String _generateUniqueAccountNumber() {
    return '${bankCode}_${_accounts.length + 1}';
  }

  
  BankAccount findAccount(String accountNumber) {
    if (!_accounts.containsKey(accountNumber)) {
      throw Exception('Account not found');
    }
    return _accounts[accountNumber]!;
  }

  
  bool removeAccount(String accountNumber) {
    bool removed = _accounts.remove(accountNumber) != null;
    print(removed ? 'Account ${accountNumber} was removed' : 'Account not found');
    return removed;
  }

  
  double getTotalDeposits() {
    return _accounts.values.fold(0, (total, account) => total + account.balance);
  }

  
  void transfer(String fromAccount, String toAccount, double amount) {
    if (amount <= 0) {
      throw ArgumentError('Transfer amount must be positive.');
    }
    try {
      BankAccount sender = findAccount(fromAccount);
      BankAccount receiver = findAccount(toAccount);

      if (sender.balance >= amount) {
        sender.withdraw(amount);
        receiver.deposit(amount);
        print('Transfer of \$${amount.toStringAsFixed(2)} successful.');
      } else {
        throw Exception('Transfer failed: Insufficient balance.');
      }
    } catch (e) {
      print('Transfer failed: ${e.toString()}');
    }
  }

  
  @override
  String toString() {
    return 'Bank Name: $bankName, Address: $address, Total Deposits: \$${getTotalDeposits().toStringAsFixed(2)}';
  }
}

void main() {
  Bank myBank = Bank('CADT Bank', '123 Main St', 'CADT');
  // Bank myBank2 = Bank('Huota Bank', '123 Main St', 'national bank 5');
  
  BankAccount account1 = myBank.createAccount('Huot', 500);
  BankAccount account2 = myBank.createAccount('Rong', 300);

  
  print(account1);
  print(account2);

  
  account1.deposit(200);
  account1.withdraw(100);

  
  myBank.transfer(account1.accountNumber, account2.accountNumber, 50);
  print(account2);
  
  print(myBank);

  
  myBank.removeAccount(account1.accountNumber);
}
