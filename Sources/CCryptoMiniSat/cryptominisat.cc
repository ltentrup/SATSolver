extern "C" {
#include "ccryptominisat.h"
}

#include "cryptominisat.h"
#include <assert.h>
#include <algorithm>

using namespace CMSat;


struct CryptoMiniSat {
    SATSolver* instance;
    std::vector<Lit> clause;
    std::vector<Lit> assumptions;
    bool last_sat;
};

CryptoMiniSat* cryptominisat_init() {
    CryptoMiniSat* solver = new CryptoMiniSat;
    solver->instance = new SATSolver();
    solver->last_sat = false;
    return solver;
}

void cryptominisat_free(CryptoMiniSat* solver) {
    delete solver->instance;
    delete solver;
}

int cryptominisat_new(CryptoMiniSat* solver) {
    // cryptominisat variables start at 0
    solver->instance->new_var();
    return solver->instance->nVars();
}

int cryptominisat_max_var(CryptoMiniSat* solver) {
    return solver->instance->nVars();
}

static Lit lit_from_int(int literal) {
    bool neg = literal < 0;
    int var = neg ? -literal : literal;
    
    return Lit(var - 1, neg);
}

void cryptominisat_add(CryptoMiniSat* solver, int literal) {
    if (literal == 0) {
        solver->instance->add_clause(solver->clause);
        solver->clause.clear();
    } else {
        Lit l = lit_from_int(literal);
        solver->clause.push_back(l);
    }
}

bool cryptominisat_solve(CryptoMiniSat* solver) {
    if (solver->last_sat) {
        solver->assumptions.clear();
    }
    solver->last_sat = true;
    return solver->instance->solve(&solver->assumptions) == l_True;
}

int cryptominisat_value(CryptoMiniSat* solver, int literal) {
    lbool res = solver->instance->get_model()[lit_from_int(literal).var()];
    if (res == l_True) {
        return 1;
    } else if (res == l_False) {
        return -1;
    } else {
        assert(res == l_Undef);
        return 0;
    }
}

void cryptominisat_assume(CryptoMiniSat* solver, int literal) {
    if (solver->last_sat) {
        solver->last_sat = false;
        solver->assumptions.clear();
    }
    solver->assumptions.push_back(lit_from_int(literal));
}

bool cryptominisat_failed(CryptoMiniSat* solver, int literal) {
    const std::vector<Lit>& conflict = solver->instance->get_conflict();
    auto it = std::find(conflict.begin(), conflict.end(), ~lit_from_int(literal));
    return it != conflict.end();
}