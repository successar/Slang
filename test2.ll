Int main(Int amt) {
    print_str("Enter size of string : ");
    LET Int size <- read_int();
    LET Str string <- sbrk(size);
    print_str("Enter the string : ");
    read_str(string, size);
    print_str(string);
}
END
