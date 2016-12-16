#!/usr/bin/env python

import sys
import simplejson, urllib

city = sys.argv[1]
country = sys.argv[2]
temp_celsius = 0
url = "http://api.openweathermap.org/data/2.5/weather"
apikey = ""

# to get API Key go here
# http://openweathermap.org/appid

# API Description:
# http://bugs.openweathermap.org/projects/api/wiki/Weather_Data

if not apikey:
	sys.exit(1)

try:
    result = simplejson.load(urllib.urlopen("%s?appid=%s&q=%s,%s" % (url, apikey, city, country)))
except:
    sys.exit(1)

temp_celsius = result['main']['temp'] - 273.15
humidity_percent = result['main']['humidity']
pressure_hpa = result['main']['pressure']
wind_mps = result['wind']['speed']

dict_out = {}
dict_out["temp"] = str(temp_celsius)
dict_out["humidity"] = str(humidity_percent)
dict_out["wind_speed"] = str(wind_mps)
dict_out["pressure"] = str(pressure_hpa)

output = ""
for k in dict_out.keys():
	output = "%s %s:%s" % (output, k, dict_out[k])

sys.stdout.write(output)
