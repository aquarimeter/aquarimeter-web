#Aquarimeter API

##Register

```
/api/v1/register
```

pass as JSON as the payload in the following format(replace obvious values):

```json
{"user":{"email":"some.fake.user@aquarimeter.rocks","password":"password123","first_name":"some fake","last_name":"user"}}'
````

### HTTP Codes ### 

```
200 -- all data is valid -- now proceed to Login.
422 -- Validation errors have occured, check JSON for errors. 
```




