#pragma once
#include <vector>
#include "ast.h"
using namespace std;

class var_table {
	protected:
	vector<Symbol> vars;
	public :
	void add_var(Symbol var) {
		vars.push_back(var);
	}

	Symbol lookup_var(Symbol sym) {
		for(int i = 0; i < vars.size(); i++ ) if( strcmp(sym->string(), vars[i]->string()) == 0 ) return vars[i];
		return NULL;
	}

	int size() { return vars.size(); }
	int lookup_index(Symbol sym) {
		for(int i = 0; i < vars.size(); i++ ) if( strcmp(sym->string(), vars[i]->string()) == 0 ) return i;
		return -1;
	}
};

class str_table : public var_table{
	public :
	Symbol operator[](int i) {
		return vars[i];
	}
};
