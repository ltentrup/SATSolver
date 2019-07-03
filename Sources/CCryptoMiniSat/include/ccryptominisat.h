#pragma once

#include <stdbool.h>

typedef struct CryptoMiniSat CryptoMiniSat;

CryptoMiniSat* cryptominisat_init(void);
void cryptominisat_free(CryptoMiniSat*);

int cryptominisat_new(CryptoMiniSat*);
int cryptominisat_max_var(CryptoMiniSat*);
void cryptominisat_add(CryptoMiniSat*, int);
void cryptominisat_assume(CryptoMiniSat*, int);
bool cryptominisat_solve(CryptoMiniSat*);
int cryptominisat_value(CryptoMiniSat*, int);
bool cryptominisat_failed(CryptoMiniSat*, int);
