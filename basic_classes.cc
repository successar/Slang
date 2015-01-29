#include "ast.h"

class Expression_class {
public:
    virtual void display(int l) {};
    virtual void check() { }
    virtual void cgen(ostream &os);
    Symbol type;
    Symbol get_type() {
        return type;
    };
};

class Block_class {
    vector<Expression> exprs;
public :
    void append_expr(Expression expr) {
        exprs.push_back(expr);
    }
    EXPR_VALS
    Symbol type;
    Symbol get_type() {
        return type;
    }
};

class Program_class {
    vector<Function> funcs;
    vector<Struct> structs;
public :
    void append_function(Function f) {
        funcs.push_back(f);
    }
    void append_struct(Struct s) {
        structs.push_back(s);
    }
    void display();
    void semant();
    void cgen(ofstream& os);
};


class Formals_class {
    vector<Symbol> args;
    vector<Symbol> types;
public :
    void append_formal(Symbol name, Symbol type) {
        args.push_back(name);
        types.push_back(type);
    }
    int size() {
        return args.size();
    }
    EXPR_VALS
};

class Function_class {
    Symbol name;
    Symbol ret_type;
    Formals args;
    Block blk;
    var_table vars;
public :
    Function_class(Symbol arg_name, Symbol arg_ret_type, Formals arg_args, Block arg_blk)
        : name(arg_name), ret_type(arg_ret_type), args(arg_args), blk(arg_blk) {}
    EXPR_VALS
};

class Expressions_class {
    vector<Expression> exprs;
public:
    void append_exp(Expression exp) {
        exprs.push_back(exp);
    }
    int size() {
        return exprs.size();
    }
    EXPR_VALS
};

class Struct_class {
    Symbol name;
    Formals args;
public :
    Struct_class(Symbol arg_name, Formals arg_args) : name(arg_name), args(arg_args) {}
    Symbol get_name() {
        return name;
    }
    EXPR_VALS
};
