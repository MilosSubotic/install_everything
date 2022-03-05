
devs_for_export = {
	'16c0:05dc' : 'USBasp'
}

import pyudev
import time


active_devs_for_export = {}
for d in devs_for_export.keys():
	active_devs_for_export[d] = False

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
		if ID == '16c0:05dc':
			for a in dev.attributes.available_attributes:
				print(a, ' : ', dev.attributes.get(a))
	
	for d in active_devs_for_export:
		if d in active_devs:
			if not active_devs_for_export[d]:
				active_devs_for_export[d] = True
				print("Binding {} {}".format(d, devs_for_export[d]))
		else:
			if active_devs_for_export[d]:
				active_devs_for_export[d] = False
				print("Unbinding {} {}".format(d, devs_for_export[d]))
	
	break
	time.sleep(1)
