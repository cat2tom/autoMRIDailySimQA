from ConfigParser import SafeConfigParser

parser = SafeConfigParser()
parser.read('sample_config.ini')

print parser.get('dirs', 'matlab_exe')

