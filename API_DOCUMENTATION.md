#Aquarimeter API

##Register

```
/api/v1/register
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
/api/v1/login
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



