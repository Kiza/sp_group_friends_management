# Common Friendship

## API
```
GET /friendship/common
```

## Input
```
{
  friends:
    [
      'andy@example.com',
      'john@example.com'
    ]
}
```

## Success output
```
{
  "success": true,
  "friends" :
    [
      'common@example.com'
    ],
  "count" : 1   
}
```

## Failed output
```
{
    "success": false,
    "error": "<error message>"
}
```

## Error messages
- `Invalid data format. Too few friends.`
- `Invalid data format. Too many friends.`
- `Invalid data format. Cannot find friends field`
- `Validation failed: User has already been taken`

## Notes:
- All email will be treated as valid
- Invalid email will casue empty friend list
- Two same emails, will case error with message `Invalid data format. Too few friends.`



