import re, time

with open('pma470_extendedlogs.log', 'r') as log_file:
    log_data = log_file.read()
    result = re.compile('(s:[0-9]*:".*";)').split(log_data)
    for item in result:
        print(result)
        time.sleep(2)
