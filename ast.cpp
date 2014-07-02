#include "ast.hpp"

#include <cstdio>
#include <iostream>
#include <typeinfo>
using namespace std;

Expr::Expr(double v) {
	val.double_val = v;
}

Expr *Expr::evaluate() {
	return this;
}

double Expr::value() {
	return val.double_val;
}

Expr *bin_add(Expr *l, Expr *r) {
	return new Expr(l->evaluate()->value() + r->evaluate()->value());
}

Expr *bin_sub(Expr *l, Expr *r) {
	return new Expr(l->evaluate()->value() - r->evaluate()->value());
}

Expr *bin_mul(Expr *l, Expr *r) {
	return new Expr(l->evaluate()->value() * r->evaluate()->value());
}

Expr *bin_div(Expr *l, Expr *r) {
	return new Expr(l->evaluate()->value() / r->evaluate()->value());
}

BinOpFunc bin_op_func[] = {
	bin_add, bin_sub, bin_mul, bin_div
};

BinOpExpr::BinOpExpr(int i, Expr *l, Expr *r)
	: op_index(i), lvalue(l), rvalue(r) {}

Expr *BinOpExpr::evaluate() {
	return bin_op_func[this->op_index](this->lvalue, this->rvalue);
}
