var server, serverOptions = ServerOptions.new;

var serverPort = 58009;

SynthDef.new(\sin,  {
        arg freq = 110, pan=0, release = 1, attack = 0.1;
        var sinOsc = SinOsc.ar(freq, mul:0.1)*EnvGen.kr(Env.perc(/*attackTime: attack,*/ releaseTime: release), doneAction: Done.freeSelf);
        //sinOsc.poll;
        Out.ar(0, Pan2.ar(in: sinOsc, pos: pan));
}).add;

serverOptions.device = "scjack:supercollider";
serverOptions.numInputBusChannels = 0;
//serverOptions.verbosity = -1;
serverOptions.protocol = \tcp; // set to use tcp
serverOptions.bindAddress = "0.0.0.0"; // set to use tcp
serverOptions.maxLogins = 10;

//"SC_JACK_DEFAULT_INPUTS".setenv();
//"SC_JACK_DEFAULT_OUTPUTS".setenv("collab-radio");

server = Server.new(\collabServer,  options: serverOptions); // non-standard server port!

serverOptions.asOptionsString(serverPort).postln;
SynthDescLib.global.addServer(server);
//server.waitForBoot({
//        "Hello".postln;
//        Synth.new(\sin, [\freq, 110+30.rand], target: server);
//});
//server.boot;

s.options.protocol = \tcp; // set to use tcp
s.options.bindAddress = "0.0.0.0"; // allow connections from any address
s.options.maxLogins = 2; // set to correct number of clients
//s.boot;