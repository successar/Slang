struct Account {
    Int acc_no,
    Str name,
    Int balance
}

Int print(Account acc) {
    print_str("Account info : ");
    print_str("\nAccount no : ");
    print_int(acc.acc_no);
    print_str("\nAccount name : ");
    print_str(acc.name);
    print_str("\nAccount balance : ");
    print_int(acc.balance);
    print_str("\n");
    0;
}


Int read_acc(Account acc) {
    print_str("Account number : ");
    acc.acc_no <- read_int();
    print_str("Account name : ");
    read_str(acc.name, 15);
    print_str("Account balance : ");
    acc.balance <- read_int();
    0;
}


Int main(Int amt) {
    Account acc[10];
    Account acc_t;
    Int a1;
    a1 <- 0;
    while( a1 < 10 ) {
        acc[a1] <- sbrk(sizeof(Account));
        acc_t <- acc[a1];
        acc_t.name <- sbrk(16);
        read_acc(acc_t);
        print(acc_t);
        a1 <- a1 + 1;
    } LOOP;
}

