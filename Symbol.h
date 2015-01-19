#include <vector>
#include <cstring>
using namespace std;

class symtab_entry {
	char* name;
	int length;
	int index;
public:
	symtab_entry(char* n) { 
		length = strlen(n); name = new char[length + 1];
		strncpy(name, n, length);
		name[length] = '\0';
	}

	char* string() const { return name; }
	int len() const { return length; }
};


	
typedef symtab_entry* Symbol;		
