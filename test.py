import eeUtil
eeUtil.initJson()
collection = 'cli_012_co2_concentrations'
print(eeUtil.exists(f'test_{collection}'))

eeUtil.createFolder(f'test_{collection}', True, public=True)

print('hola holita!')
print(eeUtil.exists(f'test_{collection}'))
eeUtil.removeAsset(f'test_{collection}')
print(eeUtil.exists(f'test_{collection}'))