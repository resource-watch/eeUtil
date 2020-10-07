import sys
import os

import eeUtil
# Initialize eeUtil
eeUtil.initJson()

def test_collectionExists():
    collection = 'cli_012_co2_concentrations'
    assert eeUtil.exists(collection), "Response metadata incorrect"
    return



