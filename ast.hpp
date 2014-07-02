#ifndef __AST_H__
#define __AST_H__

enum BIN_OPERATOR_INDEX {
	OP_ADD = 0,
	OP_SUB,
	OP_MUL,
	OP_DIV,
	OP_MOD
};

class Expr {
private:
	double val;
public:
	Expr(double v = 0) : val(v) {}
	virtual ~Expr() {}
	virtual Expr *evaluate();
	double value();
};

typedef Expr *(*BinOpFunc)(Expr *l, Expr *r);
extern BinOpFunc bin_op_func[];

class BinOpExpr : public Expr {
private:
	Expr *lvalue;
	Expr *rvalue;
	int op_index;
public:
	BinOpExpr(int i, Expr *l, Expr *r);
	virtual ~BinOpExpr() {}
	virtual Expr *evaluate();
};

#endif // __AST_H__
