LET a1 <- 0;
LET a2 <- 1;
LET a3 <- 0;
LET input <- 0;

PRINT ("Enter the value to fibonacci : ");
READ input;

WHILE ( 0 < input ) DO {
	PRINT (a3);	PRINT (" ");
	a1 <- a2;
	a2 <- a3;
	a3 <- a1 + a2;
	input <- input - 1;
}
LOOP;

PRINT ("\n");
