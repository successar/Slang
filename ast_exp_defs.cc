#define EXPR_VALS	\
	void display(int l);	\
	void cgen(ostream& os);	\
	void check();			
	

enum types {
	int_type = 1,
	str_type
};
