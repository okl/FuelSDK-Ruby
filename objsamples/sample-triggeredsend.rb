require '../ET_Client.rb'
require 'securerandom'

begin
	stubObj = ET_Client.new(false, false)

	# Get all TriggeredSendDefinitions
	p '>>> Get all TriggeredSendDefinitions'
	getTS = ET_TriggeredSend.new
	getTS.authStub = stubObj
	getTS.props = ["CustomerKey", "Name", "TriggeredSendStatus"]
	getResponse = getTS.get
	p 'Retrieve Status: ' + getResponse.status.to_s
	p 'Code: ' + getResponse.code.to_s
	p 'Message: ' + getResponse.message.to_s
	p 'MoreResults: ' + getResponse.moreResults.to_s	
	p 'Results Count: ' + getResponse.results.length.to_s
	#p 'Results: ' + getResponse.results.to_s
			
	# Specify the name of a TriggeredSend that was setup for testing 
	# Do not use a production Triggered Send Definition

	NameOfTestTS = "TEXTEXT"	
	
	# Pause a TriggeredSend
	p '>>> Pause a TriggeredSend'
	patchTrig = ET_TriggeredSend.new 
	patchTrig.authStub = stubObj
	patchTrig.props = {"CustomerKey" => NameOfTestTS, "TriggeredSendStatus" =>"Inactive"}	
	patchResponse = patchTrig.patch
	p 'Patch Status: ' + patchResponse.status.to_s
	p 'Code: ' + patchResponse.code.to_s
	p 'Message: ' + patchResponse.message.to_s
	p 'Result Count: ' + patchResponse.results.length.to_s
	p 'Results: ' + patchResponse.results.inspect
	
	# Retrieve Single TriggeredSend
	p '>>> Retrieve Single TriggeredSend'
	getTS = ET_TriggeredSend.new
	getTS.authStub = stubObj
	getTS.props = ["CustomerKey", "Name", "TriggeredSendStatus"]
	getTS.filter = {'Property' => 'CustomerKey','SimpleOperator' => 'equals','Value' => NameOfTestTS}
	getResponse = getTS.get
	p 'Retrieve Status: ' + getResponse.status.to_s
	p 'Code: ' + getResponse.code.to_s
	p 'Message: ' + getResponse.message.to_s
	p 'MoreResults: ' + getResponse.moreResults.to_s	
	p 'Results Count: ' + getResponse.results.length.to_s
	p 'Results: ' + getResponse.results.to_s
	
	# Start a TriggeredSend by setting to Active
	p '>>> Start a TriggeredSend by setting to Active'
	patchTrig = ET_TriggeredSend.new 
	patchTrig.authStub = stubObj
	patchTrig.props = {"CustomerKey" => NameOfTestTS, "TriggeredSendStatus" =>"Active"}	
	patchResponse = patchTrig.patch
	p 'Patch Status: ' + patchResponse.status.to_s
	p 'Code: ' + patchResponse.code.to_s
	p 'Message: ' + patchResponse.message.to_s
	p 'Result Count: ' + patchResponse.results.length.to_s
	p 'Results: ' + patchResponse.results.inspect
	
	# Retrieve Single TriggeredSend After setting back to active
	p '>>> Retrieve Single TriggeredSend After setting back to active'
	getTS = ET_TriggeredSend.new
	getTS.authStub = stubObj
	getTS.props = ["CustomerKey", "Name", "TriggeredSendStatus"]
	getTS.filter = {'Property' => 'CustomerKey','SimpleOperator' => 'equals','Value' => NameOfTestTS}
	getResponse = getTS.get
	p 'Retrieve Status: ' + getResponse.status.to_s
	p 'Code: ' + getResponse.code.to_s
	p 'Message: ' + getResponse.message.to_s
	p 'MoreResults: ' + getResponse.moreResults.to_s	
	p 'Results Count: ' + getResponse.results.length.to_s
	p 'Results: ' + getResponse.results.to_s	
	
	
	# Send an email with TriggeredSend
	p '>>> Send an email with TriggeredSend'
	sendTrig = ET_TriggeredSend.new 
	sendTrig.authStub = stubObj
	sendTrig.props = {"CustomerKey" => NameOfTestTS}	
	sendTrig.subscribers = [{"EmailAddress"=>"testing@bh.exacttarget.com", "SubscriberKey" => "testing@bh.exacttarget.com"}]
	sendResponse = sendTrig.send
	p 'Send Status: ' + sendResponse.status.to_s
	p 'Code: ' + sendResponse.code.to_s
	p 'Message: ' + sendResponse.message.to_s
	p 'Result Count: ' + sendResponse.results.length.to_s
	p 'Results: ' + sendResponse.results.inspect
	
	# Generate a unique identifier for the TriggeredSend customer key since they cannot be re-used even after deleted
	TSNameForCreateThenDelete = SecureRandom.uuid	
	
	# Create a TriggeredSend Definition 
	p '>>> Create a TriggeredSend Definition'
	postTrig = ET_TriggeredSend.new 
	postTrig.authStub = stubObj
	postTrig.props = {'CustomerKey' => TSNameForCreateThenDelete,'Name' => TSNameForCreateThenDelete, 'Email' => {"ID"=>"3113962"}, "SendClassification"=> {"CustomerKey"=> "2240"}}		
	postResponse = postTrig.post
	p 'Post Status: ' + postResponse.status.to_s
	p 'Code: ' + postResponse.code.to_s
	p 'Message: ' + postResponse.message.to_s
	p 'Result Count: ' + postResponse.results.length.to_s
	p 'Results: ' + postResponse.results.inspect
	
	# Delete a TriggeredSend Definition 
	p '>>> Delete a TriggeredSend Definition '
	deleteTrig = ET_TriggeredSend.new 
	deleteTrig.authStub = stubObj
	deleteTrig.props = {'CustomerKey' => TSNameForCreateThenDelete}		
	deleteResponse = deleteTrig.delete
	p 'Delete Status: ' + deleteResponse.status.to_s
	p 'Code: ' + deleteResponse.code.to_s
	p 'Message: ' + deleteResponse.message.to_s
	p 'Result Count: ' + deleteResponse.results.length.to_s
	p 'Results: ' + deleteResponse.results.inspect	
	
rescue => e
	p "Caught exception: #{e.message}"
	p e.backtrace
end

