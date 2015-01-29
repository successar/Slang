INT main(INT amt) {

LET Int a1;
LET Int input;

LET Int arr[10];

a1 <- 0;
input <- 0;

while ( a1 < 10 ) DO {
    print_str("Enter the number : ");
    input <- read_int();
    arr[a1] <- input;
    a1 <- a1 + 1;
} LOOP;
print_str("\nSelection Sort : ");

LET Int temp;
LET Int a2;
LET Int minpos;

a2 <- 0;

while ( a2 < 9 ) DO {
    a1 <- a2;
    minpos <- a2;
    while ( a1 < 10 ) DO {
        if ( arr[a1] < arr[minpos] ) THEN {  minpos <- a1; } ELSE { ; } FI;
        a1 <- a1 + 1;
    } LOOP;

    temp <- arr[a2];
    arr[a2] <- arr[minpos];
    arr[minpos] <- temp;

    a2 <- a2 + 1;
} LOOP;

a1 <- 0;
while ( a1 < 10 ) DO {
    print_str(" ");
    print_int(arr[a1]);
    a1 <- a1 + 1;
} LOOP;

print_str("\n");

} END
