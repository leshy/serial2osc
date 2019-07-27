require! {
  osc
  serialport: Serial
  "@serialport/parser-readline": Readline
}


oscPort = new osc.WebSocketPort(
    url: "ws://localhost:8081",
    metadata: true
      )

oscPort.open()

oscPort.on "ready", ->
  sendVal -> 
    oscPort.send do
      address: "/arduino/trimeraki",
      args: [ { type: "f", value: it } ]

  serialport = new Serial '/dev/ttyUSB0', autoOpen: true
  parser = port.pipe new Readline delimiter: '\r\n'
  parser.on 'data', ->
    console.log it
    sendVal Number it
