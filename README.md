# Bank Tech Test

A Maker's tech test on week 10.

## Approach

First I analysed the requirements, wrote the user stories, made a model diagram on my white board for this specific problem. I didn't want to extract too many classes to keep simplicity and the current requirements in mind. However, I still wanted to have some modularity (open/close principle and single responsibility), and I think this design is easy to extend, and easy to change (for example: if you want to extract the transaction to have its own class).

I set up my project by installing the testing frameworks (Rspec, rubocop and Capybara for feature tests).
After the setup was taken care of I made my feature test based on the requirements, and commited it.

I used the TDD approach to build my code base. I wrote unit tests, implemented it, refactored then commited.
My feature test was very compact, so I only made one of those for this simple problem.

After my feature test passed, I fixed the rubocop warnings.

At this point I might want to rename the StatementPrinter class to something else, considering the print method just returns a string didn't print it. I feel like it could be an ambigous naming, however the criteria specified an REPL enviroment, where the return value of the statement get displayed. I think in general it's good practice not to use the print method mixed with the business logic, because it leads to dependencies and hard to test.

## Design

I have 3 classes:
- Account
    - responsible for the account operations(transactions and balance)
- Transaction Log
    - responsible for keeping records of the transactions
- Statement Printer
    - responsible for making the bank statement from a transaction log


## User stories

```text
As a Client,
So that I can put my money safely in the bank,
I would like to be able to make deposits.
```

```text
As a Client,
So that I can keep track how much money is in my account,
I want to have an account balance.
```

```text
As a Client,
So that I can get my money from the bank,
I want to withdraw money from my account.
```

```text
As a Client,
So that I don't use more money than I have,
I don't want to be able to withdraw money if I don't have that much amount on my balance.
```

```text
As a Client,
So that my money tranactions are documented,
I would like my transaction dates to be stored.
```

```text
As a Client,
So that I can keep record of my account history,
I want too see my bank statement that displays my balance.
```


```text
As a Client,
So that I can keep record of my account history better,
I want too see my withdrawals with the amount my bank statement.
```

```text
As a Client,
So that I can keep record of my account history better,
I want too see my deposits with the amount my bank statement.
```

```text
As a Client,
So that I can keep record of my account history better,
I want too see my withdrawals and deposits with the dates in day, month,year format on my bank statement.
```

## Installation

In the command line:
```bash
git clone git@github.com:rekapap/bank_tech_test.git
cd bank-tech-test
bundle install
```

## Usage

In irb:
```irb
require './lib/account'
require './lib/statement_printer'
account = Account.new
account.deposit(amount: 1000, date: '10-01-2012')
account.deposit(amount: 2000, date: '13-01-2012')
account.withdraw(amount: 500, date: '14-01-2012')
print StatementPrinter.print(account.log)
```

Demo in irb:
```irb
2.5.1 :001 > require './lib/account'
 => true
2.5.1 :002 > require './lib/statement_printer'
 => true
2.5.1 :003 > account = Account.new
 => #<Account:0x00007fd6e9947e98 @balance=0, @log=#<TransactionLog:0x00007fd6e9947e20 @data=[]>>
2.5.1 :004 > account.deposit(amount: 1000, date: '10-01-2012')
 => [{:amount=>1000, :date=>#<Date: 2012-01-10 ((2455937j,0s,0n),+0s,2299161j)>, :balance=>1000}]
2.5.1 :005 > account.deposit(amount: 2000, date: '13-01-2012')
 => [{:amount=>1000, :date=>#<Date: 2012-01-10 ((2455937j,0s,0n),+0s,2299161j)>, :balance=>1000}, {:amount=>2000, :date=>#<Date: 2012-01-13 ((2455
940j,0s,0n),+0s,2299161j)>, :balance=>3000}]
2.5.1 :006 > account.withdraw(amount: 500, date: '14-01-2012')
 => [{:amount=>1000, :date=>#<Date: 2012-01-10 ((2455937j,0s,0n),+0s,2299161j)>, :balance=>1000}, {:amount=>2000, :date=>#<Date: 2012-01-13 ((2455
940j,0s,0n),+0s,2299161j)>, :balance=>3000}, {:amount=>-500, :date=>#<Date: 2012-01-14 ((2455941j,0s,0n),+0s,2299161j)>, :balance=>2500}]
2.5.1 :007 > print StatementPrinter.print(account.log)
   date    ||  credit ||  debit || balance
14/01/2012 ||         || 500.00 || 2500.00
13/01/2012 || 2000.00 ||        || 3000.00
10/01/2012 || 1000.00 ||        || 1000.00 => nil
```

## Tests

```bash
rspec
```

## Linter

```bash
rubocop
```
