# Create blacklist

## API
```
POST /blacklist
```

## Input
```
{
  "requestor": "lisa@example.com",
  "target": "john@example.com"
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
- `Validation failed: By user is not a valid email address`
- `Validation failed: To user is not a valid email address`
- `Validation failed: Blocked has already been taken`

## Notes:
- Email can block itself

