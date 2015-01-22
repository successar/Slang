Int fact(Int num) {
	if ( num = 1 ) then { 1; }
	else { num * fact(num - 1); }
	fi;
} END

INT main(INT amt) {
LET Int a1 <- 1;
print_str("Enter the number : ");
LET Int input <- read_int();

print_str("\n");

a1 <- fact(input);

print_str("The factorial is : ");
print_int(a1);
print_str("\n");

} END
