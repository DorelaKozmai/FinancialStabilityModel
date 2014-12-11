RandStream.setGlobalStream(RandStream('mt19937ar','seed',0))
run('test_setups_norand_noreg.m')
run('test_setups_randomized.m')
run('test_setups_regulator.m')