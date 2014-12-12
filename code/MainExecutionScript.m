RandStream.setGlobalStream(RandStream('mt19937ar','seed',0))

%Three different test setups
run('test_setups_standard.m')
run('test_setups_randomized.m')
run('test_setups_regulator.m')

%All figures
run('FiguresStandard.m')
run('FiguresRandomized.m')
run('FiguresRegulator.m')
