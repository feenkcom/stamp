"
The StampHeartbeatSignal is used to log information when a connection is lost, presumably due to heartbeats not being sent when they should.
"
Class {
	#name : #StampHeartbeatSignal,
	#superclass : #StampSignals,
	#instVars : [
		'lastWriteActivity',
		'lastReadActivity',
		'millisecondClockTimestamp',
		'exception'
	],
	#category : #'Stamp-Logging'
}

{ #category : #accessing }
StampHeartbeatSignal >> exception [
	^ exception
]

{ #category : #accessing }
StampHeartbeatSignal >> exception: anObject [
	exception := anObject
]

{ #category : #initialization }
StampHeartbeatSignal >> initialize [

	super initialize.
	millisecondClockTimestamp := Time millisecondClockValue.
]

{ #category : #accessing }
StampHeartbeatSignal >> lastReadActivity [
	^ lastReadActivity
]

{ #category : #accessing }
StampHeartbeatSignal >> lastReadActivity: anObject [
	lastReadActivity := anObject
]

{ #category : #accessing }
StampHeartbeatSignal >> lastWriteActivity [
	^ lastWriteActivity
]

{ #category : #accessing }
StampHeartbeatSignal >> lastWriteActivity: anObject [
	lastWriteActivity := anObject
]

{ #category : #accessing }
StampHeartbeatSignal >> millisecondClockTimestamp [
	^ millisecondClockTimestamp
]

{ #category : #accessing }
StampHeartbeatSignal >> millisecondClockTimestamp: anObject [
	millisecondClockTimestamp := anObject
]

{ #category : #printing }
StampHeartbeatSignal >> printOneLineContentsOn: stream [
	"hook to be overriden by subclasses"
	| readDelta writeDelta |

	millisecondClockTimestamp ifNil: [ ^ self ].
	lastReadActivity ifNotNil:
		[ readDelta := (millisecondClockTimestamp - lastReadActivity) milliSeconds ].
	lastWriteActivity ifNotNil:
		[ writeDelta := (millisecondClockTimestamp - lastWriteActivity) milliSeconds ].
	stream
		<< 'Read delta: ';
		<< readDelta asString;
		<< ', Write delta: ';
		<< writeDelta asString;
		<< ', exception: ';
		<< exception printString.
]
