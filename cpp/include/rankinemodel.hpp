/*
 The Rankine cycle model 

*/
#ifndef RANKINEMODEL_HPP
#define RANKINEMODEL_HPP

#include "common.hpp"
#include "rankine81.hpp"
#include "rankine82.hpp"
#include "rankine85.hpp"


rankinecycles cycles= {rankine81, rankine82, rankine85};

#endif /* RANKINEMODEL_hpp */
