' Pop-up with a text input field
' Type anything and upon pressing Ok - the text will be played on speakers 
 
 Dim message, sapi
 
message=InputBox("Type something.","TTS")
set sapi=CreateObject("sapi.spvoice")
Set sapi.Voice = sapi.GetVoices.Item(1)
sapi.volume = 100
sapi.rate = 1


for i = 0 to sapi.GetAudioOutputs.Count - 1
  s = sapi.GetAudioOutputs.item(i).getdescription
  if (instr(s,"Speakers") > 0) then
     Set sapi.AudioOutput = sapi.GetAudioOutputs.item(i)
  End If
next

sapi.Speak message

sapi.Speak "mi gusta"
