#include "ast.h"
#include <iostream>
using namespace std;

//**** Program, Struct, Function, Block ****** //
void Program_class::display() {
    for(int i = 0; i < structs.size(); i++ ) structs[i]->display(0);
    for(int i = 0; i < funcs.size(); i++ ) funcs[i]->display(0);
}

void Block_class::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;
    for(int i = 0; i < exprs.size(); i++ ) {
        exprs[i]->display(l);
    }
    cout << endl;
}

void Struct_class::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Struct " << name->string() << endl;
    cout << "\t";
    args->display(l + 1);
    cout << endl;
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "End Struct " << name->string() << endl << endl;
}

void Function_class::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Function : " << ret_type->string() << " " << name->string() << " (";
    args->display(l);
    cout << ")" << endl;
    blk->display(l + 1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "End Function " << name->string() << endl << endl;

}

//*********** Formals  arguments *********//

void Formals_class::display(int l) {
    if(args.size() > 0) {
        cout << types[0]->string() << " " << args[0]->string() ;
        for(int i = 1; i < args.size(); i++ ) cout << ", " << types[i]->string() << " " << args[i]->string();
    }
}

void Expressions_class::display(int l) {
    for(int i = 0; i < exprs.size(); i++ ) exprs[i]->display(l);
}

//***** Binary, Unary Operations ******//

void Binary::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;
    e1->display(l + 1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Binary op : " << (char) op << endl;
    e2->display(l + 1);
}

void Unary::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Unary op : " << (char) op << endl;
    e1->display(l + 1);
}

// ****** Assign , Call ******//

void Assign::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Assign : " << var->string() << endl;
    e1->display(l + 1);
}

void Call::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Function Call : " << name->string() << " Arguments : " << endl;
    args->display(l + 1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "End Function Call" << endl;
}

//******** Let, Condition, Loop *******//

void Let::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "LET : " << var->string() << endl;
}

void Cond::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Condition : " << endl;
    cond->display(l+1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "True Branch : " << endl;
    etrue->display(l+1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "False Branch : " << endl;
    efalse->display(l+1);
}

void Loop::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "While Condition : " << endl;
    cond->display(l);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Begin : " << endl;
    e1->display(l);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Loop" << endl;
}

//********* Int const, String Constant, Object *******//

void Int_const::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Integer : " << value << endl;
}

void Object::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Variable : " << var->string() << endl;
}

void Str_const::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "String : " << value->string() << endl;
}

//********* Array Operations *******//
void Array_Let::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "LET : " << var->string() << "[" << size << "]" << endl;
}

void Array_Assign::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Assign : " << var->string() << " on Position " << endl;
    pos->display(l + 1);
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Expression : " << endl;
    e1->display(l + 1);
}

void Array_Access::display(int l) {
    for(int i = 0; i < l; i++) cout << '\t';
    cout << "## Type : " << type->string() << endl;

    for(int i = 0; i < l; i++) cout << '\t';
    cout << "Access : " << var->string() << " on positon : " << endl;
    pos->display(l + 1);
}
