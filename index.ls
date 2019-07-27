require! {
  osc
  serialport: Serial
  "@serialport/parser-readline": Readline
}


[ ...rest, ip, port, serial ] = process.argv

port = Number port
console.log "serial port: ", serial
console.log "ip: ", ip
console.log "UDP port: ", port

oscPort = new osc.UDPPort do
    remoteAddress: ip,
    remotePort: port,
    metadata: true

oscPort.open()

oscPort.on "ready", ->
  sendVal = -> 
    oscPort.send do
      address: "/arduino/trimeraki",
      args: [ { type: "f", value: it } ]

  serialport = new Serial serial, autoOpen: true
  parser = serialport.pipe new Readline delimiter: '\r\n'
  
  parser.on 'data', ->
    data = String it

    number = Number data.split(' ')[2]
      
    console.log ">", number
    sendVal number
