#define FIX_LINE_NUMBERS2(sharp) sharp##line __LINE__ __FILE__
#define FIX_LINE_NUMBERS() FIX_LINE_NUMBERS2(#)

#define DECAY_WATTS 4
#define REBEL_WATTS 1.34
#define ENGINEER_WATTS 4

#define COST_RETURN_RATIO 0.25