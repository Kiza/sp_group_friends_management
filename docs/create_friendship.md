# Create Friendship

## API
```
POST /friendship
```

## Input
```
{
  "friends":
    [
      "andy@example.com",
      "john@example.com"
    ]
}
```

## Success output
```
{
    "success": true,
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
- `Validation failed: User is not a valid email address`
- `Validation failed: Friend is not a valid email address`
- `Invalid data format. Cannot find friends field`
- `Validation failed: User has already been taken`

## Notes:
- `a@b.c` is not a valid email address
- Same address cannot be friends

