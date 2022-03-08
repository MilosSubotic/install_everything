#!/usr/bin/env python3


devs_to_import = {
	'16c0:05dc' : 'USBasp'
}

SERVER_IP = '10.1.215.217'

usbip_cmd = 'usbip'

import pyudev
import time
import subprocess
import functools
import re

# Need bufferless stdout for deamon.
print = functools.partial(print, flush = True)


context = pyudev.Context()
while True:
	active_devs = []
	devices = context.list_devices(subsystem = 'usb') 
	for dev in devices:
		VID = dev.attributes.get('idVendor')
		PID = dev.attributes.get('idProduct')
		if VID == None or PID == None:
			continue
		VID = VID.decode('ascii')
		PID = PID.decode('ascii')
		ID = VID + ':' + PID
		active_devs.append(ID)
		#if ID == '16c0:05dc':
		#	for a in dev.attributes.available_attributes:
		#		print(a, ' : ', dev.attributes.get(a))
	
	for d in devs_to_import.keys():
		if d not in active_devs:
			
			cmd = [
				usbip_cmd, 'list',
				'-r', SERVER_IP
			]
			r = subprocess.run(cmd, stdout = subprocess.PIPE)
			so = r.stdout.decode('ascii')
			l = so.split('\n')
			busid = None
			for ll in l:
				print(ll)
				m = re.match('\s*(.*):.*:.*\((.*)\)', ll)
				if m:
					if m.group(2) == d:
						busid = m.group(1)
			if busid:
				print("Binding {} {}".format(d, devs_to_import[d]))
				cmd = [
					usbip_cmd, 'attach',
					'-r', SERVER_IP,
					'-b', busid
				]
				subprocess.run(cmd)
	
	time.sleep(1)
