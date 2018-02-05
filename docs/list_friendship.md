# List Friendship

## API
```
GET /friendship
```

## Input
```
{
  'email': 'andy@example.com'
}
```

## Success output
```
{
  "success": true,
  "friends" :
    [
      'john@example.com'
    ],
  "count" : 1   
}
```

## Notes:
- No error output
- All input will be treated as valid
- Invalid input will cause zero friend returned

