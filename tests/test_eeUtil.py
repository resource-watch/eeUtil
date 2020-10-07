import sys
import os

import eeUtil
# Initialize eeUtil
eeUtil.initJson()
COLLECTION = 'cli_012_co2_concentrations'

def test_collectionExists():
    assert eeUtil.exists(COLLECTION), "Response metadata incorrect"
    return

def test_listCollection():
    myCollection = eeUtil.ls(COLLECTION)
    assert len(myCollection) > 0, "Response metadata incorrect"
    return

def test_createCollection():
    eeUtil.createFolder(f'test_{COLLECTION}', True, public=True)
    
    assert len(eeUtil.ls(f'test_{COLLECTION}')) == 0, "Response metadata incorrect"
    return

def test_deleteCollection():
    myCollection = eeUtil.ls(COLLECTION)
    assert len(myCollection) > 0, "Response metadata incorrect"
    return



