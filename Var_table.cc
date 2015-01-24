#include <vector>
#include "Symbol.h"
using namespace std;

class var_table {
	protected:
	vector<Symbol> vars;
	vector<Symbol> types;
	vector<int> sizes;
	int tot_size;
	public :
    var_table() : tot_size(0) {}
	void add_var(Symbol var, Symbol type, int size = 1) {
		vars.push_back(var);
		types.push_back(type);
		sizes.push_back(size);
		tot_size += size;
	}

	Symbol lookup_var(Symbol sym) {
		for(int i = 0; i < vars.size(); i++ ) {
			if( strcasecmp(sym->string(), vars[i]->string()) == 0) return vars[i];
		}
		return NULL;
	}

	Symbol lookup_type(Symbol sym) {
		for(int i = 0; i < vars.size(); i++ ) {
			if( strcasecmp(sym->string(), vars[i]->string()) == 0) return types[i];
		}
		return NULL;
	}

	int size() {
        return tot_size;
    }

	int lookup_index(Symbol sym) {
	    int index = 0;
		for(int i = 0; i < vars.size(); i++ ) {
			if( strcasecmp(sym->string(), vars[i]->string()) == 0) return index;
			else index += sizes[i];
		}
		return -1;
	}
};

class str_table : public var_table {
	public :
	Symbol operator[](int i) {
		return vars[i];
	}

};

class type_table {
	vector<Symbol> types;
	public :
	Symbol add_type(char* type) {
		Symbol sym;
		if ( (sym = lookup_type(type)) == NULL ) { sym = new symtab_entry(type); types.push_back(sym);	}
		return sym;
	}

	Symbol lookup_type(char* type) {
		for(int i = 0; i < types.size(); i++ ) if( strcasecmp(type, types[i]->string()) == 0) return types[i];
		return NULL;
	}

};
