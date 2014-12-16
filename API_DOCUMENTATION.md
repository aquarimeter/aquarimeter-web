#Aquarimeter API

##Registeration API

```
POST /api/v1/register
```

pass as JSON as the payload in the following format(replace obvious values):

```json
{"user":{"email":"some.fake.user@aquarimeter.rocks","password":"password123","first_name":"some fake","last_name":"user"}}'
````

### HTTP Codes 

```
200 -- all data is valid -- now proceed to Login.
422 -- Validation errors have occured, check JSON for errors. 
```

## Login

Logging is important, you must save the auth_token given to you by Aquarimeter Web and pass it along in all requests that modify or create data in the system. 

```
POST /api/v1/login
```
```json
{"user":{"email":"some.fake.user@aquarimeter.rocks","password":"password123"}}
```
## Returns as JSON
- Username 
- auth_token **<-- SAVE THIS**
- All aquariums which were registered by the user and all associated sensor readings 


##HTTP Status Codes

```
200 (OK) -- if successful (check JSON for auth_token, it is how your session is tracked)
401 (Unauthorized) -- if the username and/or pass is incorrect.
```

## Logout

Logging out will terminate your session and your auth token will be reset upon the next login. 
Consider auth tokens temporary -- and they may not be valid. 


```
DELETE "/api/v1/logout?authentication_token=<token>&email=<user email>
```
### If valid you see the following response with HTTP Status Code 200 (OK)
```json
{"success":true,"info":"Logged out","data":{}}
```

###If invalid you will see the following response with HTTP Status Code 401 (Unauthorized)
````json
{"error":"The token you specified is no longer valid."}
```

##HTTP Status Codes
```
201 (accepted) - if logout is successful.

401 (Unauthorized) if an invalid token is specified
```






#Adding your Aquarium to Aquarimeter Web#

````
POST /api/v1/aquariums
````

````json
{"auth_token":"<auth token from login>","aquarium": {"name":"foobar","ideal_temp_low":"69", "ideal_temp_high":"90"}}
````

Successful creation should yield the following:

```json
{"aquarium":{"id":8,"name":"foobar","ideal_temp_low":"69.0","ideal_temp_high":"90.0","sensor_readings":[]}}
```

If your token is missing, or invalid then you will see the following:

```json
{"error":"Token is invalid"}
```

##HTTP Status Codes
```
201 (accepted) - if successful.

401 (Unauthorized) if an invalid token is specified
```

## Updating an Aquarium (editing its name or ideal upper and lower temp)

```
PATCH /api/v1/aquariums/**<insert the name of your aquarium>**?auth_token=**<insert token here>**
```

````json
{"auth_token":"HR6747C1iUM4XSRqKSsp","aquarium": {"name":"foobar"}}
````

