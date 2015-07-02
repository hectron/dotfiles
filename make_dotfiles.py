import glob
import os

file_names = glob.glob('*.dotfile')

for name in file_names:
    new_name = '.{0}'.format(name.replace('.dotfile', ''))
    os.rename(name, new_name)
    print('Renamed {0} => {1}'.format(name, new_name))
