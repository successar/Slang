INT sum(INT i1, INT i2) {
	i1 + i2;
} END

INT main(INT amt) {
LET a1 <- 0;
LET a2 <- 1;
LET a3 <- 0;
LET input <- 0;

PRINT_STR ("Enter the value to fibonacci : ");
READ_INT input;

WHILE ( 0 < input ) DO {
	PRINT_INT (a3);	
	PRINT_STR (" ");
	a1 <- a2;
	a2 <- a3;
	a3 <- sum(a1, a2);
	input <- input - 1;
}
LOOP;

PRINT_STR ("\n");
} END
