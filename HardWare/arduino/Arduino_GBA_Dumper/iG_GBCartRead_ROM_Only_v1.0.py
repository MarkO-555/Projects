import serial
import string
import sys

readBytes = 0
progress = 1

print ("GBCartRead - ROM Only v1.0 by InsideGadgets")

f = open('myrom.gba', 'wb')
ser = serial.Serial('COM3', 57600)
while 1:
    line = ser.readline()
    lineascii = ascii(line)
    if not line:
        break
    if lineascii.find('END') >= 0:
        break
    if readBytes == 1:
        writeLine = chr(int(line))
        #print (writeLine),
        progress += 1
        f.write(writeLine.encode('latin_1'))
    if lineascii.find('START') >= 0:
        readBytes = 1
    if progress % 1024 == 0:
        sys.stdout.write('#')
    print(lineascii)
ser.close()
f.close()
