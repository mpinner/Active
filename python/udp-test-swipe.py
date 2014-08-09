import socket
from time import sleep

UDP_IP = "192.168.1.177";
UDP_PORT = 8888;
#MESSAGE = 0x0101010101010101010101010101010101010101010101010110
#NOT_MESSAGE = 0x10101010101010101010101010101010101010101010101010110

#"Hello, World!";
 
print "UDP target IP:", UDP_IP;
print "UDP target port:", UDP_PORT;

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM);
	

for j in range(0,65):

	for i in range(0,26):

		MESSAGE = char(j) * i;
		print "message:", MESSAGE;
		sock.sendto(MESSAGE, (UDP_IP ,UDP_PORT));
		sleep(.5);


