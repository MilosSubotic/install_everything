#!/usr/bin/env python3


devs_for_export = {
	'16c0:05dc' : 'USBasp'
}


usbip_cmd = 'usbip'
usbipd_cmd = 'usbipd'

import pyudev
import time
import subprocess
import functools

# Need bufferless stdout for deamon.
print = functools.partial(print, flush = True)

# Run deamon process.
subprocess.run([usbipd_cmd, '-D'])


active_devs_for_export = {}
for d in devs_for_export.keys():
	active_devs_for_export[d] = False
active_devs_for_export_busid = {}

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
	
	for d in active_devs_for_export:
		if d in active_devs:
			if not active_devs_for_export[d]:
				active_devs_for_export[d] = True
				print("Binding {} {}".format(d, devs_for_export[d]))
				cmd = usbip_cmd + ' list -p -l'
				r = subprocess.run(cmd.split(), stdout = subprocess.PIPE)
				so = r.stdout.decode('ascii')
				l = so.split('\n')
				busid = None
				for ll in l:
					t = ll.split('#')
					if len(t) == 3 and t[1] == 'usbid='+d:
						busid = t[0]
				if busid:
					active_devs_for_export_busid[d] = busid
					cmd = usbip_cmd + ' bind --' + busid
					r = subprocess.run(cmd.split())
		else:
			if active_devs_for_export[d]:
				active_devs_for_export[d] = False
				#print("Unbinding {} {}".format(d, devs_for_export[d]))
				#busid = active_devs_for_export_busid[d]
				#cmd = usbip_cmd + ' unbind --' + busid
				#r = subprocess.run(cmd.split())
				
	
	time.sleep(1)
