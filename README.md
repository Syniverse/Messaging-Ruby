# Ruby SDK for SCG Messaging APIs

This is the Ruby version of the SCG API. 
The SCG APIs provides access to communication channels using SMS, MMS, 
Push Notification, OTT messaging and Voice. 

We have prepared a thin Ruby wrapper over the REST API for
these services. 

The Ruby API hides some of the REST API's constraints, like
lists being returned in logical pages of <i>n</i> records. With the
Ruby SDK, the list method returns a wrapper that implements each().

## External dependencies
Dependencies can be installed with gem.

- [rest-client](https://github.com/rest-client/rest-client)

## How to use the SDK
The Ruby SDK implements thin wrapper classes over the 
different Messaging API resources. Using these resource
classes, you can create, get, update, list, replace and delete
objects. 

# Some examples

## List all contacts
```ruby
def list_contacts(url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  # List the contacts manually, one returned data-set (page) at the time
  offset = 0
  begin
    data = api_client.contacts.list_raw({:offset => offset})
    data['list'].each {|c| puts "Contact #{c['id']} #{c['first_name']} mdn: #{c['primary_mdn']}"}
    offset += data['list'].size
  end while data['list'].size > 0

  # List the contacts conveniently, using a wrapper class that implements each()
  api_client.contacts.list.each do |c|
    puts "Contact #{c['id']} #{c['first_name']} mdn: #{c['primary_mdn']}"
  end
end
```
This program will output something like:
```
Contact 4AOXpg8dlXRCMXlWDUch73 Alice mdn: 155560000002
Contact vsXgkqhUW4eIwMColyevn7 Bob mdn: 1555898230057
```
[Full example](examples/list_contacts.rb)


## Create and update a contact

```ruby
def update_contact(url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.contacts

  cid = res.create(
      {'first_name' =>'John',
       'last_name' => 'Doe',
       'primary_mdn' => '3592884111115'})['id']

  contact = res.get(cid)

  res.update(cid, {'last_name' => 'Anderson',
                   'version_number' => contact['version_number']})

  contact = res.get(cid)
  puts "John Doe changed name to #{contact['first_name']} #{contact['last_name']}"
  res.delete(cid)
end
```
You can create an object by calling *create* with a hash
of the data values for the object you create.

In this example, please notice the *version_number* field that we copy from
the received data to the *update* argument. The server use optimistic
locking to safeguard against inconsistent updates of the data. In case
someone else updated the contact in the time window between your *get*
and *update* calls, the update will fail. In that case you must retry the
operation - first getting the data, with the new version, and then 
retrying the update with your changes - and the new *version_number*.
This pattern applies for all objects that can be updated.

The example will output:
```
John Doe changed name to John Anderson
```
[Full example](examples/update_contact.rb)

## Error handling
Errors are reported trough exceptions. Please see the 
Ruby [RestClient](https://github.com/rest-client/rest-client) library
for reference.

# Some more examples

## Sending a SMS to a GSM number

```ruby
def send_sms(senderid, mdn, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.message_requests
  request_id = res.create({'from' => 'sender_id:' + senderid,
                           'to' =>[mdn],
                           'body' => 'Hello World'})

  puts "Created message request #{request_id}"
end
```

[Full example](examples/send_sms.rb)

## Sending a Message to a Contact

This works as above, except for the to field in *create*
```ruby
    request_id = res.create({'from' => 'contact:' + contact_id,
                             'to' =>[mdn],
                             'body' => 'Hello World'})
```

## Sending a Message to a Group

Here we will create two new contacts, a new group, assign the contacts
to the group, and then send a message to the group.

```ruby
def send_sms(senderid, bob_mdm, alice_mdn, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  # Create Bob
  contact_res = api_client.contacts
  bob_id = contact_res.create(
      {'first_name' =>'Bob',
       'primary_mdn' => bob_mdm})['id']

  # Create Alice
  contact_res = api_client.contacts
  alica_id = contact_res.create(
      {'first_name' =>'Alice',
       'primary_mdn' => alice_mdn})['id']

  group_res = api_client.contact_groups
  friends_id = group_res.create({'name' => 'Our Friends'})['id']
  group_res.add_contacts(friends_id, [bob_id, alica_id])

  mrq_res = api_client.message_requests
  request_id = mrq_res.create({'from' => 'sender_id:' + senderid,
                           'to' =>['group:' + friends_id],
                           'body' => 'Hello World'})['id']

  puts "Created message request #{request_id}"

  group_res.delete friends_id
  contact_res.delete(bob_id)
  contact_res.delete(alica_id)
end
```
[Full example](examples/send_sms_to_grp.rb)

## Sending a MMS with an attachment

```ruby
def send_mms(senderid, mdn, attachment, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  att_res = api_client.attachments

  att_id = att_res.create({'name' => 'test_upload',
                           'type' => 'image/jpeg',
                           'filename' => 'cutecat.jpg'})['id']

  att_res.upload att_id, attachment

  mrq_res = api_client.message_requests
  request_id = mrq_res.create({'from' => 'sender_id:' + senderid,
                               'to' =>[mdn],
                               'attachments' => [att_id],
                               'body' => 'Hello World'})['id']

  puts "Created message request #{request_id}"
end
```

[Full example](examples/send_mms.rb)

## Checking the state of a Message Request

```ruby
def check_state(mrqId, url_arg = {})
  factory = Scg::Factory.new(url_arg);
  authenticator = factory.buildAuthenticator(json_config: 'auth.json' )
  api_client = factory.buildApiClient(authenticator)

  res = api_client.message_requests

  puts res.get mrqId
end
```

The example below may output something like:
```
{"application_id"=>888, "company_id"=>12121, 
"created_date"=>1498544910988, "last_updated_date"=>1498544913351, 
"version_number"=>2, "id"=>"aaRXWwJdXFs3MsuidEmug2", 
"from"=>"sender_id:ln9sk9JF6insXcJ5nUzKK3", 
"to"=>["15553067507"], "attachments"=>["3gflTL0rkRIDazM9JP1fQ1"], 
"body"=>"Hello World", "state"=>"COMPLETED", 
"recipient_count"=>1, "sent_count"=>0, "delivered_count"=>0, 
"media_requested_count"=>0, "read_count"=>0, 
"click_thru_count"=>0, "converted_count"=>0,  "canceled_count"=>0, 
"failed_count"=>1,  "sender_id_sort_criteria"=>[], 
"contact_delivery_address_priority"=>[]}
```

[Full example](examples/check_message_request_state.rb)

