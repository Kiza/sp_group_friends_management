
# Live API

Hosted at https://morning-castle-84945.herokuapp.com/

## live check
```
curl -X GET -H "Content-Type: application/json" https://morning-castle-84945.herokuapp.com/
> {"live":true}
```

## Create Friendship
```
curl -X POST -H "Content-Type: application/json" -d '{"friends":["aa@bb.cc", "bb@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true}

curl -X POST -H "Content-Type: application/json" -d '{"friends":["aa@bb.cc", "cc@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true}

curl -X POST -H "Content-Type: application/json" -d '{"friends":["aa@bb.cc", "dd@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true}

curl -X POST -H "Content-Type: application/json" -d '{"friends":["zz@bb.cc", "cc@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true}

curl -X POST -H "Content-Type: application/json" -d '{"friends":["zz@bb.cc", "dd@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true}

```



## List Friendship
```
curl -X GET -H "Content-Type: application/json" -d '{"email":"aa@bb.cc"}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true,"friends":["bb@bb.cc","cc@bb.cc","dd@bb.cc"],"count":3}

curl -X GET -H "Content-Type: application/json" -d '{"email":"zz@bb.cc"}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true,"friends":["cc@bb.cc","dd@bb.cc"],"count":2}

curl -X GET -H "Content-Type: application/json" -d '{"email":"cc@bb.cc"}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":true,"friends":["aa@bb.cc","zz@bb.cc"],"count":2}
```

## Common Friendship
```
curl -X GET -H "Content-Type: application/json" -d '{"friends":["aa@bb.cc", "zz@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship/common
> {"success":true,"friends":["cc@bb.cc","dd@bb.cc"],"count":2}
```

## Create subscription
```
curl -X POST -H "Content-Type: application/json" -d '{"requestor":"11@bb.cc", "target": "aa@bb.cc"}' https://morning-castle-84945.herokuapp.com/subscription
> {"success":true}

curl -X POST -H "Content-Type: application/json" -d '{"requestor":"22@bb.cc", "target": "aa@bb.cc"}' https://morning-castle-84945.herokuapp.com/subscription
> {"success":true}
```

## Create blacklist
```
curl -X POST -H "Content-Type: application/json" -d '{"requestor":"111@bb.cc", "target": "aaa@bb.cc"}' https://morning-castle-84945.herokuapp.com/blacklist
> {"success":true}

# Cannot create friendship due to blocked
curl -X POST -H "Content-Type: application/json" -d '{"friends":["111@bb.cc", "aaa@bb.cc"]}' https://morning-castle-84945.herokuapp.com/friendship
> {"success":false,"error":"Validation failed: Not blocked is false"}
```

## Recipients list
```
curl -X GET -H "Content-Type: application/json" -d '{"sender":"aa@bb.cc","text":"someone@something.com and here."}' https://morning-castle-84945.herokuapp.com/message/recipients
> {"success":true,"recipients":["bb@bb.cc","cc@bb.cc","dd@bb.cc","11@bb.cc","22@bb.cc","someone@something.com"]}

# bb@bb.cc blocks aa@bb.cc
curl -X POST -H "Content-Type: application/json" -d '{"requestor":"bb@bb.cc", "target": "aa@bb.cc"}' https://morning-castle-84945.herokuapp.com/blacklist
> {"success":true}

# bb@bb.cc will not listed in the recipients
curl -X GET -H "Content-Type: application/json" -d '{"sender":"aa@bb.cc","text":"someone@something.com and here."}' https://morning-castle-84945.herokuapp.com/message/recipients
> {"success":true,"recipients":["cc@bb.cc","dd@bb.cc","11@bb.cc","22@bb.cc","someone@something.com"]}
```