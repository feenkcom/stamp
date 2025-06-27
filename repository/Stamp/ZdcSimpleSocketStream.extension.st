Extension { #name : #ZdcSimpleSocketStream }

{ #category : #'*Stamp' }
ZdcSimpleSocketStream class >> newTcpSocket [
	| platformSocket |
	platformSocket := Socket newTCP.
	platformSocket
		setOption: 'TCP_NODELAY' value: 1;
		setOption: 'SO_SNDBUF' value: self socketBufferSize;
		setOption: 'SO_RCVBUF' value: self socketBufferSize.
	^ platformSocket
]

{ #category : #'*Stamp' }
ZdcSimpleSocketStream class >> openConnectionToHost: hostIP port: portNumber [
	| platformSocket |
	platformSocket := self newTcpSocket.
	^ (self on: platformSocket)
		connectTo: hostIP port: portNumber;
		yourself
]

{ #category : #'*Stamp' }
ZdcSimpleSocketStream class >> openConnectionToHost: hostIP port: portNumber timeout: timeout [
	| platformSocket |
	platformSocket := self newTcpSocket.
	^ (self on: platformSocket)
		timeout: timeout;
		connectTo: hostIP port: portNumber;
		yourself
]

{ #category : #'*Stamp' }
ZdcSimpleSocketStream class >> openConnectionToHostNamed: hostName port: portNumber [
	| platformSocket socketStream hostIPAddress |
	platformSocket := self newTcpSocket.
	socketStream := self on: platformSocket.
	hostIPAddress := NetNameResolver
			addressForName: hostName
			timeout: socketStream timeout.
	(hostIPAddress isNil or: [ hostIPAddress = SocketAddress zero ])
		ifTrue: [ ^ NameLookupFailure signalFor: hostName ].
	^ socketStream
		connectTo: hostIPAddress port: portNumber;
		yourself
]

{ #category : #'*Stamp' }
ZdcSimpleSocketStream class >> socketBufferSize [
	"Size in bytes for Sockets and SocketStream IO buffers"

	^ 1024 * 1024
]
