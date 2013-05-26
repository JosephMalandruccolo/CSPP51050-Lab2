Lab Deliverable 2 (Broker Pattern)  Due Tuesday, May 28th, 2013, 5:00 pm
Overview

For this assignment, you will implement the rudiments of a basic single process broker.  This will entail several activities.  Your final software deliverable will be a working broker that is fairly limited in terms of its immediate usefulness, but nevertheless, instructive as to the pattern's details and forces.  

The Broker pattern is by definition a distributed architecture pattern.  That is the primary reason for its existence.  However, writing even a simple broker is a non-trivial exercise.  It involves defining a common protocol for communication, implementing multiple language compilers (for idl), marshalling and demarshalling data, and above all, providing a remote messaging capability (by either building on top of an existing technology such as RPC or by writing your own from scratch using sockets).  And this is just the tip of the iceberg.  Again, not a trivial exercise.

One may nonetheless derive some benefit by implementing a simple broker as an in-proc (single process) solution.  The pattern will basically be the same, it's just that the details of remote communication are removed, and therefore much of the complexity in terms of protocol and transmission is abstracted.  

Requirements

Your task is to implement a broker that adds pairs of integers and calculates the length of strings. Imagine that you have a database that is very sensitive to these two operations: if two clients add integers differently (say, if they use different-sized integers that overflow at different values) or calculate the lengths of strings differently (say, using different unicode standards), the inconsistencies might cause serious bugs (or lose your a lot of money...or worse, your pride)! So, you want each client to pass these function calls to a server through a broker, who will perform the computations and return them to you.

Your deliverable should is to implement the following:

A Client that talks to a ClientProxy whenever it wants to make a call
A ClientProxy that wraps the call in a standardized format, thus implementing a common interface (see CallMesage, below)
A Server that hosts a Servant object providing the functionality of that common interface
A ServerProxy that delegates calls to the servant object's implementation by unpacking the standardized format
A Broker that communicates directly with the ClientProxy and the ServerProxy, by routing a CallMessage between the two
A standardized CallMessage format that encapsulates the details of a given "remote" call and its return
All of the above objects may be (but are not required to be) implemented within the same process space, that is, you are not required to use sockets, threads, or other forms of inter-process communication.
 

The task of the ClientProxy is to intercept a call (say "getLength(String)") from the client, box that call up into a CallMessage object (the text of the call, the content of the parameters, etc, typed), and then make a call on the Broker and pass it the "marshalled" CallMessage object.

The Broker in turn simply calls on the ServerProxy, essentially handing it the CallMessage object.

The ServerProxy "demarshalls" the CallMessage object, and calls the appropriate  implementation method on the Server's servant object implementation.  The Servant performs the call, and returns the return result through the ServerProxy, which "marshalls" the return into a CallMessage object, passes it through the Broker, which passes it back to the ClientProxy, which "demarshalls" the return result, and hands it back to the Client which originated the call.  The following assumptions are in play:

Everything is done in-proc (within a single JVM, CLR, process, etc., depending on your language)
The CallMessage class is generic enough to contain the target object reference, the name of the call to execute, the names and types of all parameters as well as their content, etc.
The flow of information from one proxy to another can be represented as follows:

Proxy -> [CallMessage] -> Broker -> [string] -> transport -> [string] -> Broker -> [CallMessage] -> Proxy

Notice that there is a transport layer between the two Brokers. This represents the information that is passed from one broker to another. For this assignment, the transport stage is modeled by the conversion of the CallMessage object to and from a string. The sending broker transforms it to a string, as though it were passing it in the form of raw bits from one process to another, and the receiving broker transforms that string to a CallMessage object.

Testing

To test your code, you should define an interface. The CallMessage format should represent the standardized format for submitting information to, and receiving information from, that interface. The ClientProxy and ServerProxy should be able to convert to and from this standardized format. The Broker should be able to convert this standardized format into a string, and convert from a string into this standardized format. The Servant should provide the common interface's functionality. The interface should be able to handle the following two method calls

int addIntegers (int val1, int val2) which adds two integers together and returns an integer result
int getLength (string str) which returns the length of the string passed in
You do NOT have to define a formal Interface Definition Language (IDL) for this project.  You can assume that you can hardcode the details of the format and protocol into the CallMessage object in lieu of a formal IDL.

Hints

Although the proxy does a lot of things, there is still the fact that there are really 2 brokers, one on each side, with a transport layer between them.

The broker is split into 2 parts: Server side and client side. There is a 'transport' layer between them.

The solution must provide a 'transport' layer in the form of a string. All data must be transformed into/from a single string.

A single string is the only thing passed between the broker client side and the broker server side.

The proxies accept multiple parameters via methods, and marshals the data into a CallMessage.

The brokers have to send and receive data. If their orb sends the message, they receive a CallMessage from their Proxy and send a string to be transported to the receiving broker. If their orb receives the message, they receive a string that was transported from the sending broker and send a CallMessage to their proxy.

Things eventually get squeezed into a byte stream.  Byte streams are easy to send/receive.

Clients and servers can be implemented in various languages, but the orbs must support a common transport.

In Buschmann, p101, it states that, "A broker's tasks include locating the appropriate server". Therefore, the solution should involve specifying some server identifying parameter. This is an important part of a correct broker pattern implementation, because the server must be decoupled from the client. The solution must go beyond simply creating layers of objects and forwarding method calls. That said, the implementation can be simplified, so that the server identification can simply be a string parameter. It can be as simple as requesting 'Lab 2 Server Broker'. Then, as part of testing, if the client requests something from another server, the broker can reply with something simple, such as, "That server is currently off-line". The server used for a call is determined at runtime, not compile time. Although, to keep things simple, the server can be created, and the choice of server object to create can be hard coded in the proxy and/or broker.

Submission

Submit your assignments in a folder called Lab_Deliverable_2 (or similar) to the subversion repository according to the directions on the syllabus page. 
Place all of your Lab 2 work into one folder. You will only be graded on your material within a reasonably labeled folder. 
Only source files and supporting files so that the code will compile (eg. make files, etc.) are required. 
Also, please include a README text file that contains the programming language you used. 
If you want to give the TAs/graders instructions on how to compile, run, or even understand your code, you can place that within the README as well.

Please ask for assistance if you have any questions: cspp51050@mailman.cs.uchicago.edu