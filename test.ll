INT sum(INT i1, INT i2, STR s1) {
	i1 + i2;
	PRINT_STR (s1);
} END

INT main(INT amt) {
LET a1 <- 1;
LET input <- 0;
LET st <- "ret";

PRINT_STR ("Enter the value to factorial : ");
READ_INT input;

WHILE ( input > 0 ) DO {
	a1 <- a1 * input;
	input <- input - 1;
	PRINT_INT (a1);	
	PRINT_STR (" ");
}
LOOP;

PRINT_STR ("\n");
sum(a1, input, st);
} END
